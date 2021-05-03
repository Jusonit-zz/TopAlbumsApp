//
//  AlbumsController.swift
//  TopAlbums
//
//  Created by Rave Bizz on 5/1/21.
//

import Foundation

struct AlbumService {
    
    private let urlString = "https://rss.itunes.apple.com/api/v1/us/itunes-music/top-albums/all/100/explicit"

    typealias AlbumCompletion = ((Result<[Album], NetworkErrors>) -> Void)
    
    func fetchTopAlbums(completion: @escaping (AlbumCompletion)) {
        let url = URL(string: urlString)!
        let requetUrl = url.appendingPathExtension("json")
        
        NetworkManager.performRequest(for: requetUrl, httpMethod: .get) { (data, error) in
            
            if let error = error {
                print("Error performing Network Request \(error) \(#file) \(#function)")
                completion(.failure(.forwarded(error))); return
            }
            guard let date = data else { completion(.failure(.noDataReturned)); return }
            
            do {
                
                let results = try JSONDecoder().decode(AlbumJson.self, from: date).feed.results
                completion(.success(results))
                
            } catch let e {
                print("Error with JsonDecoder \(e) \(e.localizedDescription)")
                completion(.failure(.dataNotDecodable)); return
            }
        }
    }
}
