//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Евгения Шевякова on 22.03.2022.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let spacing: CGFloat = 16
        static let screenWidth = UIScreen.main.bounds.width
    }

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
        customInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customInit() {
        selectionStyle = .none
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubviews(
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
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.spacing),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.spacing),
            
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: Constants.screenWidth),
            postImageView.widthAnchor.constraint(equalToConstant: Constants.screenWidth),

            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: Constants.spacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.spacing),

            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.spacing),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.spacing),

            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.spacing),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.spacing),
        ])
    
    }
}
