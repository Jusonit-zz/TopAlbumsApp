//
//  AlbumJson.swift
//  TopAlbums
//
//  Created by Rave Bizz on 5/1/21.
//

import Foundation

struct AlbumJson: Codable {
    
    var feed: FeedJson
    
    struct FeedJson: Codable {
        
        var results: [AlbumModel]
        
    }
}
