//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Евгения Шевякова on 01.04.2022.
//

import UIKit
import iOSIntPackage

final class PhotosViewController: UIViewController {
    
    // MARK: - Properties
    
    enum Constants {
        static let spacing: CGFloat = 8
        static let screenWidth = UIScreen.main.bounds.width
    }
    
    private var photos = [UIImage]()
    
    private let contentFactory = ContentFactory()
    
    private let imagePublisher = ImagePublisherFacade()

    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        collection.toAutoLayout()
        
        return collection
    }()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupViews()
        setConstraints()
        
        imagePublisher.subscribe(self)
        imagePublisher.addImagesWithTimer(
            time: 0.5,
            repeat: 20,
            userImages: contentFactory.photos()
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imagePublisher.removeSubscription(for: self)
    }
    
    // MARK: - Methods
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
       
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier:
                PhotosCollectionViewCell.identifier
        )
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    func update(title: String) {
        navigationItem.title = title
    }
    
}

// MARK: - Extension: UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath)
        
        if let cell = cell as? PhotosCollectionViewCell {
            cell.update(with: photos[indexPath.row])
        }
        return cell
    }
}

// MARK: - Extension: UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = itemWidth(for: Constants.screenWidth, spacing: Constants.spacing)
        
        return CGSize(width: width, height: width)
    }
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        
        let itemsInRow: CGFloat = 3
        let totalSpacing: CGFloat = (2 + (itemsInRow - 1)) * spacing
        let itemWidth = (width - totalSpacing) / itemsInRow
        
        return floor(itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: Constants.spacing, left: Constants.spacing, bottom: Constants.spacing, right: Constants.spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constants.spacing
    }

}

// MARK: - Extension: ImageLibrarySubscriber

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        photos = images
        collectionView.reloadData()
    }
    
}
