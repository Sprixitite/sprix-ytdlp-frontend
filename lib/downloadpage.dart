import "dart:io";
import "package:flutter/material.dart";
import "package:dropdown_button2/dropdown_button2.dart";

List<String> defaultSettings = [
  "--abort-on-error",
  "--no-embed-info-json",
  "--add-metadata",
  "--embed-thumbnail",
  "--write-thumbnail",
  "--parse-metadata",
  ":(?P<meta_synopsis>)",
  "--parse-metadata",
  ":(?P<meta_purl>)",
  "--parse-metadata",
  ":(?P<meta_synopsis>)",
  "-o%(title)s.%(ext)s"
];

const leftRoundedOutline = OutlineInputBorder(
                             borderRadius: BorderRadius.only(
                               topLeft: Radius.circular(10000),
                               bottomLeft: Radius.circular(10000)
                             )
                           );

const rightRoundedOutline = OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10000),
                                bottomRight: Radius.circular(10000)
                              )
                            );

class DownloadForm extends StatefulWidget {
  const DownloadForm({
    super.key,
    required this.formats,
    required this.downloadType,
    this.downloadTypeArgs = ""
  });

  final Map<String, List<String>> formats;
  final String downloadType;
  final String downloadTypeArgs;

  @override
  DownloadFormState createState() {
    return DownloadFormState(
      formats: formats,
      downloadType: downloadType,
      downloadTypeArgs: downloadTypeArgs
    );
  }

}

class DownloadFormState extends State<DownloadForm> {
  DownloadFormState({
    required this.formats,
    required this.downloadType,
    required this.downloadTypeArgs
  });

  final _formKey = GlobalKey<FormState>();
  final Map<String, List<String>> formats;
  final String downloadType;
  final String downloadTypeArgs;

  late String videoUrl;
  late String downloadFolder;
  late String downloadFormat;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: leftRoundedOutline,
                          hintText: "Enter Video URL"
                        ),
                        autocorrect: false,
                        enableSuggestions: false,
                        validator: (value) {
                          return value == null || value.isEmpty ? "Please Enter A Video URL!" : null;
                        },
                        onSaved: (value) => videoUrl = value ?? "",
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 190),
                      child: DropdownButtonFormField2(
                        alignment: Alignment.center,
                        decoration: const InputDecoration(border: rightRoundedOutline),
                        hint: Text("$downloadType Format"),
                        isDense: true,
                        isExpanded: true,
                        items: formats.keys.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            alignment: Alignment.center,
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                        validator: (value) {
                          return value == null || value.isEmpty ? "Please Select A File Format!" : null;
                        },
                        onSaved: (value) => downloadFormat = value ?? "",
                        style: const TextStyle(
                          decorationColor: Colors.transparent
                        ),
                      ),
                    )
                  ],
                )
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        autocorrect: false,
                        decoration: const InputDecoration(
                          border: leftRoundedOutline,
                          hintText: "Enter Output Folder"
                        ),
                        enableSuggestions: false,
                        validator: (value) {
                          return value == null || value.isEmpty ? "Please Enter An Output Folder!" : null;
                        },
                        onSaved: (value) => downloadFolder = value ?? "",
                      )
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      constraints: const BoxConstraints(maxWidth: 190),
                      child: FilledButton(
                        style: const ButtonStyle(
                          visualDensity: VisualDensity(
                            horizontal: VisualDensity.maximumDensity,
                            vertical: VisualDensity.maximumDensity
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10000),
                                bottomRight: Radius.circular(10000)
                              )
                            )
                          )
                        ),
                        onPressed: () {},
                        child: const Text("Open File Picker")
                      )
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Downloading $downloadType(s)...')),
                    );
                    
                    var downloadDir = Directory(downloadFolder);
                    await downloadDir.create();

                    var flags = <String>[
                      downloadTypeArgs,
                      ...formats[downloadFormat] ?? [],
                      ...defaultSettings,
                      videoUrl
                    ];

                    var result = await Process.run(
                      "yt-dlp",
                      flags,
                      workingDirectory: downloadFolder
                    );

                    switch ( result.exitCode ) {
                      case 0:
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Successfully Downloaded $downloadType(s)!')),
                        );
                        break;

                      default:
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed To Download $downloadType(s)...')),
                        );
                        
                        break;
                    }

                    print(result.stdout);
                    print(result.stderr);


                  }
                },
                child: const Text("Download")
              )
            ],
          ),
        ),
    );
  }
}