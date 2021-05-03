//
//  AlbumDetails.swift
//  TopAlbums
//
//  Created by Rave Bizz on 5/1/21.
//

import Foundation

struct AlbumModel: Codable, Album {
    
    var name: String
    var artistName: String
    var artworkUrl100: String
    var copyright: String
    var artistId: String
    var url: URL
    var releaseDate: String
    var genres: [GenreDictionary]
    var id: String
    
    var hdArtworkString: String {
        let urlString = artworkUrl100
        return (urlString.replacingOccurrences(of: "200", with: "1000"))
    }
}

struct GenreDictionary: Codable {
    var name: String
}
