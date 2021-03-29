package com.pehlivanov.zlati.flutter_id3_reader

import android.content.ContentUris
import android.content.Context
import android.media.MediaMetadataRetriever
import android.net.Uri
import android.provider.MediaStore
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler


class MainMethodCallHandler(
        private val applicationContext: Context,
        private val messenger: BinaryMessenger
) : MethodCallHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val request = call.arguments<Map<*, *>>()
        when (call.method) {
            "getTag" -> {
                val filePath = request.get<Any?, Any?>("filePath") as String
                val remote = request.get<Any?, Any?>("remote") as Boolean
                val metaRetriever = MediaMetadataRetriever()
                if (remote) {
                    metaRetriever.setDataSource(filePath, HashMap())
                } else {
                    metaRetriever.setDataSource(filePath)
                }

                val duration: String =
                        metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DURATION)
                val title: String =
                        metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_TITLE)
                val album: String =
                        metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ALBUM)
                val artist: String =
                        metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ARTIST)


                val artBytes: ByteArray = metaRetriever.embeddedPicture

                val dur: Int = duration.toInt()

                val resMap = mapOf(
                        "title" to title,
                        "album" to album,
                        "artist" to artist,
                        "duration" to dur,
                        "albumArt" to artBytes,
                        "fileUri" to filePath
                )

                result.success(resMap)
            }
            "getSongs" -> {
                val provider = SongsProvider(applicationContext)
                val songs: List<SongInfo> = provider.provideAudioData()
                Log.d("songs", songs.toString())
                provider.close()

                val resList = mutableListOf<Map<String, Any>>()
                songs.forEach {
                    resList.add(
                            mapOf(
                                    "id" to it.id,
                                    "title" to it.title,
                                    "artist" to it.artist,
                                    "artistId" to it.artistId,
                                    "album" to it.album,
                                    "albumId" to it.albumId,
                                    "duration" to it.duration,
                                    "bookmark" to it.bookmark,
                                    "year" to it.year,
                                    "fileUri" to it.fileUri,
                                    "fileSize" to it.fileSize,
                                    "absolutePath" to it.absolutePath,
                                    "isMusic" to it.isMusic,
                                    "isPodcast" to it.isPodcast,
                                    "isRingtone" to it.isRingtone,
                                    "isAlarm" to it.isAlarm,
                                    "isNotification" to it.isNotification
                            )
                    )
                }

                result.success(resList)
            }
            "getAlbumArt" -> {
                val mediaIdObject = request.get<Any?, Any?>("mediaId")
                val mediaId: Long = (mediaIdObject as Int).toLong();

                val metaRetriever = MediaMetadataRetriever()
                val fileUri: Uri = ContentUris.withAppendedId(MediaStore.Audio.Media.EXTERNAL_CONTENT_URI, mediaId);
                metaRetriever.setDataSource(applicationContext, fileUri)
                val artBytes: ByteArray? = metaRetriever.embeddedPicture

                result.success(artBytes)
            }

            else -> result.notImplemented()
        }

    }

}
