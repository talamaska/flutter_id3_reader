import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_id3_reader/flutter_id3_reader.dart';
import 'package:flutter_id3_reader_platform_interface/flutter_id3_reader_platform_interface.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      print('${tag.toString()}');
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
        body: Center(
          child: RaisedButton(
            child: Text('get tag'),
            onPressed: () {
              getTag();
            },
          ),
        ),
      ),
    );
  }
}
