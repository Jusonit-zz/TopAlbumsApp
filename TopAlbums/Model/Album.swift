//
//  Album.swift
//  TopAlbums
//
//  Created by Rave Bizz on 5/1/21.
//

import Foundation

protocol Album {
    var name: String { get }
    var artistName: String { get }
    var artworkUrl100: String { get }
    var copyright: String { get }
    var artistId: String { get }
    var url: URL { get }
    var releaseDate: String { get }
    var genres: [GenreDictionary] { get }
    var hdArtworkString: String { get }
    var id: String { get }
}
