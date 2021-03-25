// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:async';
import 'dart:typed_data';
import 'package:meta/meta.dart';
import 'package:flutter_id3_reader_platform_interface/flutter_id3_reader_platform_interface.dart';
export 'package:flutter_id3_reader_platform_interface/flutter_id3_reader_platform_interface.dart'
    show SongInfo, TagResponse, AlbumArtRequest;

class FlutterId3Reader {
  static Future<TagResponse> getTag(
    String path, {
    @required bool remote,
  }) async {
    final TagResponse tag =
        await FlutterId3ReaderPlatform.instance.getTag(TagRequest(
      filePath: path,
      remote: remote,
    ));
    return tag;
  }

  static Future<Uint8List> getAlbumArt({
    @required int mediaId
  }) async {
    final Uint8List tag =
        await FlutterId3ReaderPlatform.instance.getAlbumArt(AlbumArtRequest(
      mediaId: mediaId
    ));
    return tag;
  }

  static Future<List<SongInfo>> getSongs() async {
    final List<SongInfo> tags =
        await FlutterId3ReaderPlatform.instance.getSongs();
    return tags;
  }
}
