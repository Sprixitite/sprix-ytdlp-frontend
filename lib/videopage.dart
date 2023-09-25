import 'package:flutter/material.dart';
import "downloadpage.dart";

const Map<String, List<String>> videoFormats = {
  "Best Quality":[],
  ".MP4": ["--format", "mp4"],
  ".3GP": ["--format", "3gp"],
  ".FLV": ["--format", "flv"],
  ".WEBM":["--format", "webm"]
};

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

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
          title: const Text("Video Downloader")
        ),
        body: const DownloadForm(formats: videoFormats, downloadType: "Video",)
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