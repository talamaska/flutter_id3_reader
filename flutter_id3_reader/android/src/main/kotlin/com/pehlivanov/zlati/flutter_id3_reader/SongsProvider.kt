package com.pehlivanov.zlati.flutter_id3_reader

import android.annotation.SuppressLint
import android.content.ContentUris
import android.content.Context
import android.database.Cursor

import android.net.Uri
import android.provider.MediaStore
import android.util.Log
import java.io.Closeable
import java.util.concurrent.TimeUnit

/**
 *
 */
class SongsProvider(context: Context) : Closeable {
    private val audioCollection: Uri = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.Q) {
        MediaStore.Audio.Media.getContentUri(
                MediaStore.VOLUME_EXTERNAL_PRIMARY
        )
    } else {
        MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
    }

    @SuppressLint("InlinedApi")
    val selection = "${MediaStore.Video.Media.DURATION} >= ?"
    private val selectionArgs = arrayOf(
            TimeUnit.MILLISECONDS.convert(30, TimeUnit.SECONDS).toString()
    )

    // Display videos in alphabetical order based on their display name.
    private val sortOrder = "${MediaStore.Audio.Media.ARTIST} ASC"

    private val contentProviderAudio = context.contentResolver.query(
            audioCollection,
            PROJECTION,
            null,
            null,
            null
    )


    @SuppressLint("InlinedApi")
    fun provideAudioData(): List<SongInfo> {
        val results = mutableListOf<SongInfo>()

        contentProviderAudio?.takeIf { it.moveToFirst() }?.use { cursor ->
            do {
                Log.d("cursor", cursor.getStringValue(MediaStore.Audio.Media.TITLE))
                val mediaId: Long = cursor.getLongValue(MediaStore.Audio.Media._ID)
                val fileUri: Uri = ContentUris.withAppendedId(MediaStore.Audio.Media.EXTERNAL_CONTENT_URI, mediaId)

                results.add(
                        SongInfo(
                                cursor.getIntValue(MediaStore.Audio.Media._ID),
                                cursor.getStringValue(MediaStore.Audio.Media.TITLE),
                                cursor.getStringValue(MediaStore.Audio.Media.ARTIST),
                                cursor.getIntValue(MediaStore.Audio.Media.ARTIST_ID),
                                cursor.getStringValue(MediaStore.Audio.Media.ALBUM),
                                cursor.getIntValue(MediaStore.Audio.Media.ALBUM_ID),
                                cursor.getIntValue(MediaStore.Audio.Media.DURATION),
                                cursor.getIntValue(MediaStore.Audio.Media.BOOKMARK),
                                cursor.getIntValue(MediaStore.Audio.Media.YEAR),
                                fileUri.toString(),
                                (cursor.getIntValue(MediaStore.Audio.Media.IS_MUSIC) != 0),
                                (cursor.getIntValue(MediaStore.Audio.Media.IS_PODCAST) != 0),
                                (cursor.getIntValue(MediaStore.Audio.Media.IS_RINGTONE) != 0),
                                (cursor.getIntValue(MediaStore.Audio.Media.IS_ALARM) != 0),
                                (cursor.getIntValue(MediaStore.Audio.Media.IS_NOTIFICATION) != 0),
                                cursor.getIntValue(MediaStore.Audio.Media.SIZE),
                                cursor.getStringValue(MediaStore.Audio.Media.DATA)
                        )
                )
            } while (cursor.moveToNext())
        }


        return results
    }


    override fun close() {
        contentProviderAudio?.close()
    }

    companion object {
        @SuppressLint("InlinedApi")
        private val PROJECTION = arrayOf(
                MediaStore.Audio.Media._ID,
                MediaStore.Audio.Media.TITLE,
                MediaStore.Audio.Media.ARTIST,
                MediaStore.Audio.Media.ARTIST_ID,
                MediaStore.Audio.Media.ALBUM,
                MediaStore.Audio.Media.ALBUM_ID,
                MediaStore.Audio.Media.DURATION,
                MediaStore.Audio.Media.BOOKMARK,
                MediaStore.Audio.Media.YEAR,
                MediaStore.Audio.Media.IS_MUSIC,
                MediaStore.Audio.Media.IS_PODCAST,
                MediaStore.Audio.Media.IS_RINGTONE,
                MediaStore.Audio.Media.IS_ALARM,
                MediaStore.Audio.Media.IS_NOTIFICATION,
                MediaStore.Audio.Media.SIZE,
                MediaStore.Audio.Media.DATA
        )
    }
}

data class SongInfo(
        val id: Int,
        val title: String,
        val album: String,
        val albumId: Int,
        val artist: String,
        val artistId: Int,
        val duration: Int,
        val bookmark: Int,
        val year: Int,
        val fileUri: String,
        val isMusic: Boolean,
        val isPodcast: Boolean,
        val isRingtone: Boolean,
        val isAlarm: Boolean,
        val isNotification: Boolean,
        val fileSize: Int,
        val absolutePath: String
)

private fun Cursor.getIntValue(forColumn: String) =
        getColumnIndex(forColumn).takeIf { it >= 0 }?.let { getInt(it) } ?: 0

private fun Cursor.getStringValue(forColumn: String) =
        getColumnIndex(forColumn).takeIf { it >= 0 }?.let { getString(it) } ?: ""

private fun Cursor.getLongValue(forColumn: String) =
        getColumnIndex(forColumn).takeIf { it >= 0 }?.let { getLong(it) } ?: 0L

