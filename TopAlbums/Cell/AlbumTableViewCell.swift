//
//  AlbumTableViewCell.swift
//  TopAlbums
//
//  Created by Rave Bizz on 5/1/21.
//

import Foundation
import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    var album: Album? {
        didSet {
            nameLabel.text = album?.name
            artistLabel.text = album?.artistName
            ImageSingleton.shared.runImage(from: album?.artworkUrl100 ?? "") { [weak self] image in
                self?.artworkImageView.image = image
            }
        }
    }
    
    let artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = UIColor.semiboldWhite
        label.numberOfLines = 0
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .thin)
        label.textColor = UIColor.thinWhite
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubviews(artworkImageView, nameLabel, artistLabel)
        applyImageViewConstraints()
        configureStackView()
    }
    
    func applyImageViewConstraints() {
        artworkImageView.anchor(top: topAnchor,
                                paddingTop: 20,
                                bottom: bottomAnchor,
                                paddingBottom: 20,
                                left: leftAnchor,
                                paddingLeft: 12,
                                right: nil,
                                paddingRight: 0,
                                width: 150,
                                height: 150)
    }
    
    func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, artistLabel])
        stackView.axis = .vertical
        stackView.spacing = 7
        addSubview(stackView)

        stackView.anchorWith(top: artworkImageView.topAnchor,
                             paddingTop: 32,
                             bottom: nil,
                             paddingBottom: 0,
                             left: artworkImageView.rightAnchor,
                             paddingLeft: 15,
                             right: rightAnchor,
                             paddingRight: 15,
                             width: 0,
                             greaterHeight: 55)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
