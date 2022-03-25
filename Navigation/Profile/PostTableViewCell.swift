//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Евгения Шевякова on 22.03.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.numberOfLines = 2
        label.toAutoLayout()
        
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.toAutoLayout()
        
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont(name: "Avenir Next", size: 14)
        label.numberOfLines = 0
        label.toAutoLayout()
        
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.toAutoLayout()
        
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.toAutoLayout()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        addSubviews(
            authorLabel,
            postImageView,
            descriptionLabel,
            likesLabel,
            viewsLabel
        )
    }
    
    public func update(with post: Post) {
        authorLabel.text = post.author
        postImageView.image = UIImage(named: post.image)
        descriptionLabel.text = post.description
        likesLabel.text = "Likes: " + String(post.likes)
        viewsLabel.text = "Views: " + String(post.views)
    }
    
    private func setConstraints() {
        let screenWidth = UIScreen.main.bounds.width
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: screenWidth),
            postImageView.widthAnchor.constraint(equalToConstant: screenWidth),

            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),

            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16)
        ])
    
    }
}
