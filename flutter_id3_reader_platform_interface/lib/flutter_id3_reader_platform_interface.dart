import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

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

class AlbumArtRequest {
  final int mediaId;

  AlbumArtRequest({
    @required this.mediaId,
  });

  Map<dynamic, dynamic> toMap() => {
    'mediaId': mediaId,
  };

  @override
  String toString() => 'AlbumArtRequest(mediaId: $mediaId)';
}

class TagResponse {
  final String title;
  final String artist;
  final String album;
  final int duration;
  final String fileUri;
  final Uint8List albumArt;

  TagResponse({
    @required this.title,
    @required this.artist,
    @required this.album,
    @required this.duration,
    @required this.fileUri,
    this.albumArt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'artist': artist,
      'album': album,
      'duration': duration,
      'fileUri': fileUri,
      'albumArt': albumArt,
    };
  }

  factory TagResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TagResponse(
      title: map['title'] as String,
      artist: map['artist'] as String,
      album: map['album'] as String,
      duration: map['duration'] as int,
      fileUri: map['fileUri'] as String,
      albumArt: map['albumArt'] as Uint8List,
    );
  }

  String toJson() => json.encode(toMap());

  factory TagResponse.fromJson(String source) =>
      TagResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TagResponse(title: $title, artist: $artist, album: $album, duration: $duration, fileUri: $fileUri, albumArt: Uint8List)';
  }
}

class SongInfo {
  final int id;
  final String title;
  final String album;
  final int albumId;
  final String artist;
  final int artistId;
  final String fileUri;
  final int duration;
  final int bookmark;
  final String absolutePath;
  final bool isMusic;
  final bool isPodcast;
  final bool isRingtone;
  final bool isAlarm;
  final bool isNotification;
  final int fileSize;
  final int year;

  SongInfo({
    this.id,
    this.title,
    this.album,
    this.albumId,
    this.artist,
    this.artistId,
    this.fileUri,
    this.duration,
    this.bookmark,
    this.absolutePath,
    this.isMusic,
    this.isPodcast,
    this.isRingtone,
    this.isAlarm,
    this.isNotification,
    this.fileSize,
    this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'album': album,
      'albumId': albumId,
      'artist': artist,
      'artistId': artistId,
      'fileUri': fileUri,
      'duration': duration,
      'bookmark': bookmark,
      'absolutePath': absolutePath,
      'isMusic': isMusic,
      'isPodcast': isPodcast,
      'isRingtone': isRingtone,
      'isAlarm': isAlarm,
      'isNotification': isNotification,
      'fileSize': fileSize,
      'year': year,
    };
  }

  factory SongInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

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
  }

  String toJson() => json.encode(toMap());

  factory SongInfo.fromJson(String source) =>
      SongInfo.fromMap(json.decode(source));

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SongInfo &&
        o.id == id &&
        o.title == title &&
        o.album == album &&
        o.albumId == albumId &&
        o.artist == artist &&
        o.artistId == artistId &&
        o.fileUri == fileUri &&
        o.duration == duration &&
        o.bookmark == bookmark &&
        o.absolutePath == absolutePath &&
        o.fileSize == fileSize &&
        o.isMusic == isMusic &&
        o.isPodcast == isPodcast &&
        o.isRingtone == isRingtone &&
        o.isAlarm == isAlarm &&
        o.year == year &&
        o.isNotification == isNotification;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        album.hashCode ^
        albumId.hashCode ^
        artist.hashCode ^
        artistId.hashCode ^
        fileUri.hashCode ^
        duration.hashCode ^
        bookmark.hashCode ^
        absolutePath.hashCode ^
        fileSize.hashCode ^
        year.hashCode ^
        isMusic.hashCode ^
        isPodcast.hashCode ^
        isRingtone.hashCode ^
        isAlarm.hashCode ^
        isNotification.hashCode;
  }

  @override
  String toString() {
    return '''SongInfo(
      id: $id, 
      title: $title, 
      album: $album, 
      albumId: $albumId, 
      artist: $artist, 
      artistId: $artistId, 
      fileUri: $fileUri, 
      duration: $duration, 
      bookmark: $bookmark, 
      absolutePath: $absolutePath, 
      isMusic: $isMusic, 
      isPodcast: $isPodcast, 
      isRingtone: $isRingtone, 
      isAlarm: $isAlarm, 
      isNotification: $isNotification, 
      fileSize: $fileSize, 
      year: $year
    )''';
  }

  SongInfo copyWith({
    int id,
    String title,
    String album,
    int albumId,
    String artist,
    int artistId,
    String fileUri,
    int duration,
    int bookmark,
    String absolutePath,
    bool isMusic,
    bool isPodcast,
    bool isRingtone,
    bool isAlarm,
    bool isNotification,
    int fileSize,
    int year,
  }) {
    return SongInfo(
      id: id ?? this.id,
      title: title ?? this.title,
      album: album ?? this.album,
      albumId: albumId ?? this.albumId,
      artist: artist ?? this.artist,
      artistId: artistId ?? this.artistId,
      fileUri: fileUri ?? this.fileUri,
      duration: duration ?? this.duration,
      bookmark: bookmark ?? this.bookmark,
      absolutePath: absolutePath ?? this.absolutePath,
      isMusic: isMusic ?? this.isMusic,
      isPodcast: isPodcast ?? this.isPodcast,
      isRingtone: isRingtone ?? this.isRingtone,
      isAlarm: isAlarm ?? this.isAlarm,
      isNotification: isNotification ?? this.isNotification,
      fileSize: fileSize ?? this.fileSize,
      year: year ?? this.year,
    );
  }
}

/// The interface that implementations of flutter_id3_reader must implement.
///
/// Platform implementations should extend this class rather than implement it
/// as `flutter_id3_reader` does not consider newly added methods to be breaking
/// changes. Extending this class (using `extends`) ensures that the subclass
/// will get the default implementation, while platform implementations that
/// `implements` this interface will be broken by newly added
/// [JustAudioPlatform] methods.
abstract class FlutterId3ReaderPlatform extends PlatformInterface {
  /// Constructs a JustAudioPlatform.
  FlutterId3ReaderPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterId3ReaderPlatform _instance = MethodChannelFlutterId3Reader();

  /// The default instance of [FlutterId3ReaderPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterId3Reader].
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

  Future<List<SongInfo>> getSongs() {
    throw UnimplementedError('getSongs() has not been implemented.');
  }

  Future<Uint8List> getAlbumArt(AlbumArtRequest request) {
    throw UnimplementedError('getAlbumArt() has not been implemented.');
  }
}
