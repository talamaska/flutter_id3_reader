import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'flutter_id3_reader_platform_interface.dart';

/// An implementation of [FlutterId3ReaderPlatform] that uses method channels.
class MethodChannelFlutterId3Reader extends FlutterId3ReaderPlatform {
  static final _mainChannel =
      MethodChannel('com.pehlivanov.zlati.flutter_id3_reader.methods');

  @override
  Future<TagResponse> getTag(TagRequest request) async {
    Map<String, dynamic> data = await (_mainChannel
            .invokeMapMethod<String, dynamic>('getTag', request.toMap())
        as FutureOr<Map<String, dynamic>>);
    final TagResponse response = TagResponse.fromMap(data);
    return response;
  }

  @override
  Future<Uint8List?> getAlbumArt(AlbumArtRequest request) async {
    Uint8List? data = await _mainChannel.invokeMethod<Uint8List>(
        'getAlbumArt', request.toMap());

    return data;
  }

  @override
  Future<List<SongInfo>> getSongs() async {
    List<Map<dynamic, dynamic>>? data =
        await _mainChannel.invokeListMethod<Map<dynamic, dynamic>>('getSongs');
    if (data == null) {
      return <SongInfo>[];
    }

    return data.map((Map<dynamic, dynamic> item) {
      return SongInfo(
        id: item['id'] as int,
        title: item['title'] as String,
        album: item['album'] as String,
        albumId: item['albumId'] as int,
        artist: item['artist'] as String,
        artistId: item['artistId'] as int,
        duration: item['duration'] as int,
        bookmark: item['bookmark'] as int,
        fileUri: item['fileUri'] as String,
        absolutePath: item['absolutePath'] as String,
        isMusic: item['isMusic'] as bool,
        isPodcast: item['isPodcast'] as bool,
        isRingtone: item['isRingtone'] as bool,
        isAlarm: item['isAlarm'] as bool,
        isNotification: item['isNotification'] as bool,
        fileSize: item['size'] as int,
        year: item['year'] as int,
      );
    }).toList();
  }
}
