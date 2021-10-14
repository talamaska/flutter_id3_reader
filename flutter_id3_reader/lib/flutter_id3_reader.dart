import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_id3_reader_platform_interface/flutter_id3_reader_platform_interface.dart';

export 'package:flutter_id3_reader_platform_interface/flutter_id3_reader_platform_interface.dart'
    show SongInfo, TagResponse, AlbumArtRequest;

class FlutterId3Reader {
  static Future<TagResponse> getTag(
    String path, {
    required bool remote,
  }) async {
    final TagResponse tag =
        await FlutterId3ReaderPlatform.instance.getTag(TagRequest(
      filePath: path,
      remote: remote,
    ));
    return tag;
  }

  static Future<Uint8List?> getAlbumArt({required int mediaId}) async {
    final Uint8List? tag = await FlutterId3ReaderPlatform.instance
        .getAlbumArt(AlbumArtRequest(mediaId: mediaId));
    return tag;
  }

  static Future<List<SongInfo>> getSongs() async {
    final List<SongInfo> tags =
        await FlutterId3ReaderPlatform.instance.getSongs();
    return tags;
  }
}
