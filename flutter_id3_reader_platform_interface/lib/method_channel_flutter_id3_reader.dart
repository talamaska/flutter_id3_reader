import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'flutter_id3_reader_platform_interface.dart';

/// An implementation of [FlutterId3ReaderPlatform] that uses method channels.
class MethodChannelFlutterId3Reader extends FlutterId3ReaderPlatform {
  static const _mainChannel =
      const MethodChannel('com.pehlivanov.zlati.flutter_id3_reader.methods');

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
    List<SongInfo> response = [];
    try {
      response = data.map((Map<dynamic, dynamic> map) {
        return SongInfo(
          id: map['id'],
          title: map['title'],
          album: map['album'],
          albumId: map['albumId'],
          artist: map['artist'],
          artistId: map['artistId'],
          fileUri: map['fileUri'],
          duration: map['duration'],
          bookmark: map['bookmark'],
          absolutePath: map['absolutePath'],
          isMusic: map['isMusic'],
          isPodcast: map['isPodcast'],
          isRingtone: map['isRingtone'],
          isAlarm: map['isAlarm'],
          isNotification: map['isNotification'],
          fileSize: map['fileSize'],
          year: map['year'],
        );
      }).toList();
    } catch (e) {
      log('exception $e');
    }
    return response;
  }
}
