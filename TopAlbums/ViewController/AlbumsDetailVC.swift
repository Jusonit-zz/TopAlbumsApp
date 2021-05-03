//
//  AlbumsDetailVC.swift
//  TopAlbums
//
//  Created by Rave Bizz on 5/1/21.
//

import UIKit
import StoreKit

class AlbumsDetailVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFullImage()
    }
    
    // MARK: - Update Views
    
    func updateViews() {
        view.backgroundColor = .mainColor
        guard let album = album else { return }
        title = album.artistName
        coppyRightLabel.text = album.copyright
        nameLabel.text = album.name
        genreLabel.text = album.genres.first?.name ?? "Music"
        releaseDateLabel.text = album.releaseDate
    }
    
    func updateFullImage() {
        guard let hdString = album?.hdArtworkString else { return }
        UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.artworkImageView.loadImage(imagePath: hdString)
        }, completion: nil)
    }
    
    func setConstraints() {
        view.addSubview(artworkImageView)
        view.addSubview(coppyRightLabel)
        view.addSubview(nameLabel)
        view.addSubview(genreLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(itunesBtn)
    
        artworkImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 0, right: view.rightAnchor, paddingRight: 0, width: 0, height: view.bounds.height / 3)
        coppyRightLabel.anchor(top: artworkImageView.bottomAnchor, paddingTop: 8, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 40, right: view.rightAnchor, paddingRight: 40, width: 0, height: 14)
        nameLabel.anchorWith(top: coppyRightLabel.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 15, right: view.rightAnchor, paddingRight: 15, width: 0, greaterHeight: 30)
        let stackView = UIStackView(arrangedSubviews:  [genreLabel, releaseDateLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        view.addSubview(stackView)
        stackView.anchor(top: nameLabel.bottomAnchor, paddingTop: 5, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 15, right: view.rightAnchor, paddingRight: 15, width: 0, height: 50)
        
        itunesBtn.anchor(top: nil, paddingTop: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, left: view.leftAnchor, paddingLeft: 20, right: view.rightAnchor, paddingRight: 20, width: 0, height: 50)
        itunesBtn.addTarget(self, action: #selector(viewAlbumBtnTapped), for: .touchUpInside)
     
    }
    
    // MARK: - Actions

    @objc func viewAlbumBtnTapped() {
        
        #if targetEnvironment(simulator)
        showNoActionAlert(titleStr: "Ops. No Device", messageStr: "This is a simulator not a device. Can't open album id \(album?.id ?? "") in iTunes", style: .cancel)
        #else
        openItunesWith(identifier: album?.id ?? "563355119")

        #endif
    }
    
    // MARK: - Properties
    
    var album: Album?
    var artworkImage: UIImage? {
        didSet {
            artworkImageView.image = artworkImage
        }
    }
    
    let artworkImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let coppyRightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        label.numberOfLines = 0
        label.textColor = .thinWhite
        label.textAlignment = .center
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .semiboldWhite
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        label.numberOfLines = 0
        label.textColor = .semiboldWhite
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 0
        label.textColor = .semiboldWhite
        return label
    }()
    
    let itunesBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("View in iTunes", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .mainPurple
        return btn
    }()
}

extension AlbumsDetailVC: SKStoreProductViewControllerDelegate {
    
    func openItunesWith(identifier: String) {
        let storeViewController = SKStoreProductViewController()
        storeViewController.delegate = self

        let parameters = [ SKStoreProductParameterITunesItemIdentifier : identifier]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        storeViewController.loadProduct(withParameters: parameters) { [weak self] (loaded, error) -> Void in
            if let error = error {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                print("Error loading SKStore \(error.localizedDescription)")
                self?.showNoActionAlert(titleStr: "Error Loading iTunes", messageStr: error.localizedDescription, style: .cancel)
            }
            if loaded {
                self?.present(storeViewController, animated: true, completion: {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                })
            }
        }
    }

    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
