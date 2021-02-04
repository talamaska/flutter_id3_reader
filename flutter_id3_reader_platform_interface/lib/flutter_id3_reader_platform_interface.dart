import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart' show required;
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_flutter_id3_reader.dart';

class TagRequest {
  final String filePath;
  final bool remote;

  TagRequest({
    @required this.filePath,
    @required this.remote,
  });

  Map<dynamic, dynamic> toMap() => {
        'filePath': filePath,
        'remote': remote,
      };

  @override
  String toString() => 'TagRequest(filePath: $filePath, remote: $remote)';
}

class TagResponse {
  final String title;
  final String artist;
  final String album;
  final int duration;

  TagResponse({
    @required this.title,
    @required this.artist,
    @required this.album,
    @required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'artist': artist,
      'album': album,
      'duration': duration,
    };
  }

  factory TagResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TagResponse(
      title: map['title'],
      artist: map['artist'],
      album: map['album'],
      duration: map['duration'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TagResponse.fromJson(String source) =>
      TagResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TagResponse(title: $title, artist: $artist, album: $album, duration: $duration)';
  }
}

/// The interface that implementations of just_audio must implement.
///
/// Platform implementations should extend this class rather than implement it
/// as `just_audio` does not consider newly added methods to be breaking
/// changes. Extending this class (using `extends`) ensures that the subclass
/// will get the default implementation, while platform implementations that
/// `implements` this interface will be broken by newly added
/// [JustAudioPlatform] methods.
abstract class FlutterId3ReaderPlatform extends PlatformInterface {
  /// Constructs a JustAudioPlatform.
  FlutterId3ReaderPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterId3ReaderPlatform _instance = MethodChannelFlutterId3Reader();

  /// The default instance of [JustAudioPlatform] to use.
  ///
  /// Defaults to [MethodChannelJustAudio].
  static FlutterId3ReaderPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [FlutterId3ReaderPlatform] when they register themselves.
  // TODO(amirh): Extract common platform interface logic.
  // https://github.com/flutter/flutter/issues/43368
  static set instance(FlutterId3ReaderPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<TagResponse> getTag(TagRequest request) {
    throw UnimplementedError('getTag() has not been implemented.');
  }
}
