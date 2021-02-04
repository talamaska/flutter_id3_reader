import 'dart:async';

import 'package:flutter/services.dart';

import 'flutter_id3_reader_platform_interface.dart';

/// An implementation of [FlutterId3ReaderPlatform] that uses method channels.
class MethodChannelFlutterId3Reader extends FlutterId3ReaderPlatform {
  static final _mainChannel =
      MethodChannel('com.pehlivanov.zlati.flutter_id3_reader.methods');

  @override
  Future<TagResponse> getTag(TagRequest request) async {
    Map<String, dynamic> data = await _mainChannel
        .invokeMapMethod<String, dynamic>('getTag', request.toMap());
    final TagResponse response = TagResponse.fromMap(data);
    return response;
  }
}
