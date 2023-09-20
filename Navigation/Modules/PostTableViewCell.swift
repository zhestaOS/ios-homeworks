//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Евгения Шевякова on 22.03.2022.
//

import UIKit
import StorageService
import iOSIntPackage

final class PostTableViewCell: UITableViewCell {
    
    var doubleTapAction: ((Post) -> Void)?
    var post: Post!
    
    private enum Constants {
        static let spacing: CGFloat = 16
        static let screenWidth = UIScreen.main.bounds.width
    }
    
    // MARK: - Properties
    
    let imageProcessor = ImageProcessor()

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
    
    // MARK: - Life cycle
    
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
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        recognizer.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(recognizer)
    }
    
    // MARK: - Methods
    
    private func addSubviews() {
        contentView.addSubviews(
            authorLabel,
            postImageView,
            descriptionLabel,
            likesLabel,
            viewsLabel
        )
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
    
    private func applyFilter(imageName: String) {
        guard let image = UIImage(named: imageName), let filter = ColorFilter.allCases.randomElement() else {
            return
        }
        imageProcessor.processImage(sourceImage: image, filter: filter) { image in
            self.postImageView.image = image
        }
    }
    
    public func update(with post: Post) {
        self.post = post
        authorLabel.text = post.author
        descriptionLabel.text = post.textValue
        likesLabel.text = "Likes: " + String(post.likes)
        viewsLabel.text = "Views: " + String(post.views)
        applyFilter(imageName: post.image)
    }
    
    @objc
    func doubleTap() {
        doubleTapAction?(post)
    }
    
}
