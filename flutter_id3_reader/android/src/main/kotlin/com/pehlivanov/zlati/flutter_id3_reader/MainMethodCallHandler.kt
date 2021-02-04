package com.pehlivanov.zlati.flutter_id3_reader

import android.content.Context
import android.media.MediaMetadataRetriever
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler


class MainMethodCallHandler(private val applicationContext: Context,
                            private val messenger: BinaryMessenger) : MethodCallHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val request = call.arguments<Map<*, *>>()
        when (call.method) {
            "getTag" -> {
                val filePath = request.get<Any?, Any?>("filePath") as String
                val remote = request.get<Any?, Any?>("remote") as Boolean
                val metaRetriever = MediaMetadataRetriever()
                if(remote) {
                    metaRetriever.setDataSource(filePath, HashMap())
                } else {
                    metaRetriever.setDataSource(filePath)
                }
                
                val duration: String = metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DURATION)
                val title: String = metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_TITLE)
                val album: String = metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ALBUM)
                val artist: String = metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ARTIST)

                val dur: Int = duration.toInt()

                val resMap = mapOf("title" to title, "album" to album, "artist" to artist, "duration" to dur)

                result.success(resMap);
            }

            else -> result.notImplemented()
        }
    }

}