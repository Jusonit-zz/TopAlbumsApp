//
//  AlbumsListTableVC.swift
//  TopAlbums
//
//  Created by Rave Bizz on 5/2/21.
//

import UIKit

class AlbumsListTableVC: UITableViewController{
    
    let albumService: AlbumService
    private let albumDetailVC = AlbumsDetailVC()
    private var albums: [Album] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setUpUi()
        fetchAlbums()
    }
    
    func configureTableView() {
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: Constants.albumCellId)
    }
    
    func setUpUi() {
        view.backgroundColor = .mainColor2
        title = "Top Albums"
        tableView.separatorStyle = .none
    }
    
    func fetchAlbums() {
        albumService.fetchTopAlbums { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let albums):
                self.albums = albums
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showNoActionAlert(titleStr: "Error Displaying Albums", messageStr: error.localizedDescription, style: .cancel)
                }
            }
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Init
    
    init(albumService: AlbumService) {
        self.albumService = albumService
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = self.albums[indexPath.row]
        let albumDetailVC = AlbumsDetailVC()
        albumDetailVC.album = album
        
        navigationController?.pushViewController(albumDetailVC, animated: true)
    }
}
