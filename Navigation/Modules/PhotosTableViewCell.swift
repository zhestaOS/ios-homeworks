//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Евгения Шевякова on 30.03.2022.
//

import UIKit

final class PhotosTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let spacing: CGFloat = 12
        static let screenWidth = UIScreen.main.bounds.width
        static let photoPreviewSize = (screenWidth - 2 * spacing - 24) / 4
    }
    
    // MARK: - Properties
            
    private let photosLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Bold", size: 24)
        label.text = "Photos"
        label.toAutoLayout()
        
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.tintColor = .black
        imageView.toAutoLayout()
        
        return imageView
    }()
    
    private let photosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.toAutoLayout()
        
        return stackView
    }()
    
    private let photoPreview1: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "photo1")
        imageView.toAutoLayout()
        
        return imageView
    }()
    
    private let photoPreview2: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "photo2")
        imageView.toAutoLayout()
        
        return imageView
    }()
    
    private let photoPreview3: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "photo3")
        imageView.toAutoLayout()
        
        return imageView
    }()
    
    private let photoPreview4: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "photo4")
        imageView.toAutoLayout()
        
        return imageView
    }()
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func addSubviews() {
        contentView.addSubviews(
            photosLabel,
            arrowImageView,
            photosStackView
        )
        
        photosStackView.addArrangedSubview(photoPreview1)
        photosStackView.addArrangedSubview(photoPreview2)
        photosStackView.addArrangedSubview(photoPreview3)
        photosStackView.addArrangedSubview(photoPreview4)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.spacing),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.spacing),
            arrowImageView.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            
            photoPreview1.widthAnchor.constraint(equalToConstant: Constants.photoPreviewSize),
            photoPreview1.heightAnchor.constraint(equalToConstant: Constants.photoPreviewSize),
            
            photoPreview2.widthAnchor.constraint(equalToConstant: Constants.photoPreviewSize),
            photoPreview2.heightAnchor.constraint(equalToConstant: Constants.photoPreviewSize),
            
            photoPreview3.widthAnchor.constraint(equalToConstant: Constants.photoPreviewSize),
            photoPreview3.heightAnchor.constraint(equalToConstant: Constants.photoPreviewSize),
            
            photoPreview4.widthAnchor.constraint(equalToConstant: Constants.photoPreviewSize),
            photoPreview4.heightAnchor.constraint(equalToConstant: Constants.photoPreviewSize),
            
            photosStackView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: Constants.spacing),
            photosStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            photosStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.spacing),
            photosStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.spacing),
            
        ])
    
    }
}
