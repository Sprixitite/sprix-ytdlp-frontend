import 'package:flutter/material.dart';
import "videopage.dart";
import "audiopage.dart";

void main() {
  runApp(const MainApp());
}

void navToVideoDownloadMenu(context) { 
  Navigator.push(
    context, MaterialPageRoute(builder: (context) {
      return const VideoPage();
    }
    )
  );
}

void navToAudioDownloadMenu(context) {
  Navigator.push(
    context, MaterialPageRoute(builder: (context) {
      return const AudioPage();
    }
    )
  );
}

void onAdvancedDownload() {

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
    );
  }

}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Youtube Downloader", textScaleFactor: 4,),
              Text.rich(
                TextSpan(
                  text: "By ",
                  children: [
                    TextSpan(
                      text: "Sprix",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade500
                      )
                    ),
                    const TextSpan(text: " ( local nerd )")
                  ]
                ),
                textScaleFactor: 1.25,
              ),
              const SizedBox(height: 32,),
              ElevatedButton(
                onPressed: ()=>navToVideoDownloadMenu(context),
                child: const Text("Download Video")
              ),
              const SizedBox(height: 8,),
              ElevatedButton(
                onPressed: ()=>navToAudioDownloadMenu(context),
                child: const Text("Download Audio")
              ),
              const SizedBox(height: 8,),
              Text.rich(
                TextSpan(
                  text: "Please note this is ",
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontStyle: FontStyle.italic,
                    color: Colors.green.shade900
                  ),
                  children: [
                    TextSpan(
                      text:  "incomplete beta software",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.green.shade800
                      )
                    )
                  ]
                )
              )
              /*const ElevatedButton(
                onPressed: onAdvancedDownload,
                child: Text("Download Using Command-Line Arguments [ Advanced ]")
              )*/
            ],
          )
        ),
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
      themeMode: ThemeMode.dark,
    );
  }
}
