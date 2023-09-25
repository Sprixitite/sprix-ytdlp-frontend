import 'package:flutter/material.dart';
import "downloadpage.dart";

const Map<String, List<String>> audioFormats = {
  "Best Quality":[],
  ".AAC"  :  ["--audio-format", "aac"],
  ".FLAC" :  ["--audio-format", "flac"],
  ".M4A"  :  ["--audio-format", "m4a"],
  ".MP3"  :  ["--audio-format", "mp3"],
  ".OGG"  :  ["--audio-format", "vorbis"],
  ".OPUS" :  ["--audio-format", "opus"],
  ".WAV"  :  ["--audio-format", "wav"]
};

class AudioPage extends StatelessWidget {
  const AudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("<-")
              ),
            ),
          ),
          title: const Text("Audio Downloader")
        ),
        body: const DownloadForm(formats: audioFormats, downloadType: "Audio", downloadTypeArgs: "-x",)
      ),
      theme: ThemeData(
        colorSchemeSeed: Colors.green.shade500,
        brightness: Brightness.light,
        useMaterial3: true
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.green.shade500,
        brightness: Brightness.dark,
        useMaterial3: true
      ),
      themeMode: ThemeMode.system,
    );
  }
}