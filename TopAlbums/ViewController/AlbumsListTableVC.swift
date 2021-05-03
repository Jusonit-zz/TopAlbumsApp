//
//  AlbumsListTableVC.swift
//  TopAlbums
//
//  Created by Rave Bizz on 5/2/21.
//

import UIKit

class AlbumsListTableVC: UITableViewController{
    
    // MARK: - Properties
    let albumController: AlbumsController
    fileprivate var albums = [Album]()
    private let albumDetailVC = AlbumsDetailVC()
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: Constants.albumCellId)
        tableView.prefetchDataSource = self
        
        setUpUi()
        fetchAlbums()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - UI
    
    func setUpUi() {
        view.backgroundColor = .mainColor2
        title = "Top Albums"
        tableView.separatorStyle = .none
    }
    
    func fetchAlbums() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        albumController.fetchTopAlbums { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let albums):
                self.albums = albums
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.showNoActionAlert(titleStr: "Error Displaying Albums", messageStr: error.localizedDescription, style: .cancel)
                }
            }
        }
    }

    
    // MARK: - Init
    
    init(albumController: AlbumsController) {
        self.albumController = albumController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("We aren't using storyboard")
    }
    
}

extension AlbumsListTableVC {
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.albumCellId, for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }
        
        let album = albums[indexPath.row]
        cell.album = album
        cell.artworkPath = album.artworkUrl100
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        guard let cell = tableView.cellForRow(at: indexPath) as? AlbumTableViewCell else { return }
        
        let album = self.albums[indexPath.row]
        let albumDetailVC = AlbumsDetailVC()
        albumDetailVC.album = album
        albumDetailVC.artworkImage = cell.artworkImageView.image
        navigationController?.pushViewController(albumDetailVC, animated: true)
    }
    
    
    @objc func goToDetailVC() {
        let albumDetailVC = AlbumsDetailVC()
        navigationController?.pushViewController(albumDetailVC, animated: true)
    }
}

extension AlbumsListTableVC: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indxPath in indexPaths {
            let album = self.albums[indxPath.row]
            guard let url = URL(string: album.artworkUrl100) else { return }
            URLSession.shared.dataTask(with: url).resume()
        }
    }
}
