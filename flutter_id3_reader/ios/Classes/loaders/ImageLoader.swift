//
//  ArtworkLoader.swift
//  flutter_audio_query
//
//  Created by lukas on 15.09.20.
//

import Foundation
import MediaPlayer

class ImageLoader {
    
    private let noCloudItems = MPMediaPropertyPredicate(value: false, forProperty: MPMediaItemPropertyIsCloudItem)
    
    init() {
       
    }
    
    func getArtworkByID(_ result: FlutterResult, _ id: String, _ resource: Int, _ width: Double?, _ height: Double?) -> Void {
        //get all artworks and convert to a map
        
        var filter: Set<MPMediaPropertyPredicate>
        
        switch resource {
            case 0:
                filter = [MPMediaPropertyPredicate(value: UInt64(id), forProperty: MPMediaItemPropertyArtistPersistentID), noCloudItems]
            case 1:
                filter = [MPMediaPropertyPredicate(value: UInt64(id), forProperty: MPMediaItemPropertyAlbumPersistentID), noCloudItems]
            case 2:
                filter = [MPMediaPropertyPredicate(value: UInt64(id), forProperty: MPMediaItemPropertyPersistentID), noCloudItems]
            default:
                filter = [MPMediaPropertyPredicate(value: UInt64(id), forProperty: MPMediaItemPropertyPersistentID), noCloudItems]
        }
        
        let allItems = MPMediaQuery.init(filterPredicates: filter).items
        
        if let item = allItems?[0] {
            guard let data = item.artwork?.image(at: CGSize(width: width ?? 256, height: height ?? 256))?.pngData() else {
                result(FlutterError.self)
                return
            }

            let resultMap = ["image": data]
            
            result(resultMap)
        
        }
        
    }
    
    static func getArtworkBytes(_ id: String, _ width: Double?, _ height: Double?) -> Data? {
        //get all artworks and convert to a map
        let filter: Set<MPMediaPropertyPredicate> = [MPMediaPropertyPredicate(value: UInt64(id), forProperty: MPMediaItemPropertyPersistentID), MPMediaPropertyPredicate(value: false, forProperty: MPMediaItemPropertyIsCloudItem)]
        let allItems = MPMediaQuery.init(filterPredicates: filter).items
        
        if let item = allItems?[0] {
            guard let data = item.artwork?.image(at: CGSize(width: width ?? 250, height: height ?? 250))?.pngData() else {
                return nil
            }
            return data
        }
        return nil
    }
    
}
