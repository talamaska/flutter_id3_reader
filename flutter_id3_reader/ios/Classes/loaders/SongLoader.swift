//
//  SongLoader.swift
//  flutter_id3_reader
//
//

import Foundation
import MediaPlayer

class SongLoader {
    
    private let noCloudItems = MPMediaPropertyPredicate(value: false, forProperty: MPMediaItemPropertyIsCloudItem)
    
    init() {
       
    }
    
    func getSongs(_ result: FlutterResult, _ sortType: SongSortType) -> Void {
        //get all songs and convert to a map
        let allSongs = MPMediaQuery.init(filterPredicates: [noCloudItems]).items
        
        createSongListAndReturn(result, sortType, allSongs)
    }
    
    private func createSongListAndReturn(_ result: FlutterResult, _ sortType: SongSortType, _ allSongs: [MPMediaItem]?){
        var songsList: [[String: Any]] = []
        for song in allSongs! {
            //get song name and ID
            let songName = song.title 
            let songID = String(song.persistentID)
            let songAlbumName = song.albumTitle 
            let songAlbumID = String(song.albumPersistentID)
            let songArtistName = song.artist 
            let songArtistID = String(song.artistPersistentID)
            let songComposerName = song.composer 
            let songYear = song.year 
            let songAlbumTrack = String(song.albumTrackNumber)
            let songDuration = String(Double(song.playbackDuration)).replacingOccurrences(of: ".", with: "")
            let songBookmark = nil
            let songDataPath = song.assetURL?.absoluteString 
            let songURI = song.assetURL?.absoluteString 
            let songSize = 0
            let songPodcast = song.podcastTitle != nil
            //add song to returning collection
            songsList.append([
                "artist": songArtistName, 
                "artistId": songArtistID, 
                "album": songAlbumName, 
                "albumId": songAlbumID, 
                "title": songName, 
                "id": songID ,
                "year": songYear, 
                "duration": songDuration, 
                "bookmark": songBookmark, 
                "absolutePath": songDataPath, 
                "fileUri": songURI, 
                "fileSize": songSize, 
                "isMusic": !songPodcast, 
                "isPodcast": songPodcast, 
                "isAlarm": false, 
                "isRingtone": false, 
                "isNotification": false
            ])
        }
        
        sortSongListAndReturn(result, sortType, songsList)
    }
    
    private func sortSongListAndReturn(_ result: FlutterResult, _ sortType: SongSortType, _ songsList: [[String: String]]){
        //remove duplicates
        var sortedSongList = Array(Set(songsList))
        //sort by sortType
        switch sortType {
        case .DEFAULT:
            sortedSongList.sort{$0["title"]!.first! < $1["title"]!.first!}
        case .ALPHABETIC_ALBUM:
            sortedSongList.sort{$0["album"]!.first! < $1["album"]!.first!}
        case .ALPHABETIC_ARTIST:
            sortedSongList.sort{$0["artist"]!.first! < $1["artist"]!.first!}
        case .DISPLAY_NAME:
            sortedSongList.sort{$0["absolutePath"]!.first! < $1["absolutePath"]!.first!}
        case .GREATER_DURATION:
            sortedSongList.sort{$0["duration"]! > $1["duration"]!}
        case .SMALLER_DURATION:
            sortedSongList.sort{$0["duration"]! < $1["duration"]!}
        case .CURRENT_IDs_ORDER:
            sortedSongList.sort{$0["id"]! < $1["id"]!}
        default:
            break;
        }
        
        //debug
        for song in sortedSongList {
            print(song["title"] ?? "n/a")
        }
        
        print("\(sortedSongList.count)" + " songs")
        
        result(sortedSongList)
    }
    
}
