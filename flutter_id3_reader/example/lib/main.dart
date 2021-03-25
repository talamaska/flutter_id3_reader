import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_id3_reader/flutter_id3_reader.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TagResponse songInfo;
  List<SongInfo> songs = [];

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getTag() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TagResponse tag = await FlutterId3Reader.getTag(
        'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
        remote: true,
      );
      setState(() {
        songInfo = tag;
      });
      print('${tag.toString()}');
    } on PlatformException {
      print('Failed to get id3.');
    }
  }

  Future<void> getAlbumArt() async {
    var test = await FlutterId3Reader.getAlbumArt(
        mediaId: 31
    );
    print('test art $test');
  }

  Future<void> getPhoneTags() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      var status = await Permission.storage.status;
      if (!status.isPermanentlyDenied) {
        if (status.isGranted) {
          final List<SongInfo> _songs = await FlutterId3Reader.getSongs();
          setState(() {
            songs = _songs;
          });
          print('${_songs.toString()}');
        } else if (await Permission.storage.request().isGranted) {
          final List<SongInfo> _songs = await FlutterId3Reader.getSongs();
          setState(() {
            songs = _songs;
          });
          print('${_songs.toString()}');
        }
      }
    } on PlatformException {
      print('Failed to get id3.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(children: [
          RaisedButton(
            child: Text('get tag'),
            onPressed: () {
              getTag();
            },
          ),
          RaisedButton(
            child: Text('get all tags'),
            onPressed: () {
              getPhoneTags();
            },
          ),
          RaisedButton(
            child: Text('get Album Art'),
            onPressed: () {
              getAlbumArt();
            },
          ),
          if (songInfo != null) Image.memory(songInfo.albumArt),
          if (songs.isNotEmpty)
            ...List.generate(songs.length, (index) => Text(songs[index].title))
          // Image.file(File(songs[0].albumArt)),
        ]),
      ),
    );
  }
}
