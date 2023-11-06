//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Евгения Статива on 28.11.2021.
//

import UIKit
import StorageService
import ProgressHUD
import MobileCoreServices

final class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: ProfileViewModelProtocol
    
    private var posts = [Post]()
    
    private let contentFactory = ContentFactory()
    
    private let header = ProfileTableHeaderView()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        table.toAutoLayout()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            table.dragInteractionEnabled = true
        }
        
        return table
    }()
    
    // MARK: - Life cycle
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header.isUserInteractionEnabled = true
        
        header.update(user: viewModel.user)
                
        #if DEBUG
        header.backgroundColor = .systemOrange
        #else
        header.backgroundColor = .systemGreen
        #endif

        addSubviews()
        setupViews()
        setConstraints()
                        
        let result = contentFactory.posts()
        switch result {
        case .success(let success):
            posts = success
        case .failure(let error):
            Alert.shared.showError(with: "Что то пошло не так, повторите попытку", vc: self)
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            tableView.dragDelegate = self
            tableView.dropDelegate = self
        }
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Methods
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableHeaderView = header
        header.setNeedsLayout()
        header.layoutIfNeeded()
        header.frame.size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        tableView.tableFooterView = UIView()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Extension

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath)

        if let cell = cell as? PostTableViewCell {
            cell.update(with: posts[indexPath.row])
            cell.doubleTapAction = { [weak self] post in
                self?.viewModel.addPostToFavs(post: post, completion: { isSuccess in
                    if isSuccess {
                        ProgressHUD.show(icon: .added)
                    } else {
                        ProgressHUD.show(icon: .failed)
                    }
                })
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let nextVC = PhotosViewController()
            nextVC.update(title: "Photo Gallery")
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
}

extension ProfileViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let post = posts[indexPath.row]
        let stringData = post.textValue.data(using: .utf8)
        
        let stringItemProvider = NSItemProvider()
        stringItemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { completion in
            completion(stringData, nil)
            return nil
        }
        
        var result = [UIDragItem(itemProvider:stringItemProvider)]
        
        
        if let image = post.image {
            let imageItemProvider = NSItemProvider(object: image)
            let dragItem = UIDragItem(itemProvider:imageItemProvider)
            dragItem.localObject = image
            
            result.append(dragItem)
        }
        

        return result
    }
}

extension ProfileViewController: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        var dropProposal = UITableViewDropProposal(operation: .cancel)
        guard session.items.count == 1 else { return dropProposal }
        
        if tableView.hasActiveDrag {
            if tableView.isEditing {
                dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        } else {
            dropProposal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }

        return dropProposal
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let coordinatorIndexPath = coordinator.destinationIndexPath
        let destinationIndexPath = IndexPath(item: coordinatorIndexPath?.row ?? 0, section: 1)
        
        for item in coordinator.items {
            var cachedImage: UIImage?
            var cachedString: String?
            
            item.dragItem.itemProvider.loadObject(ofClass: UIImage.self) { provider, error in
                DispatchQueue.main.async {
                    if let image = provider as? UIImage {
                        cachedImage = image
                    }
                }
            }
            item.dragItem.itemProvider.loadObject(ofClass: NSString.self) { provider, error in
                DispatchQueue.main.async {
                    if let text = provider as? String {
                        cachedString = text
                    }
                    let post = Post(
                        author: "Drag&Drop",
                        image: cachedImage,
                        imageName: "",
                        description: cachedString ?? "",
                        likes: 0,
                        views: 0
                    )
                    self.posts.insert(post, at: destinationIndexPath.row)
                    self.tableView.insertRows(at: [destinationIndexPath], with: .automatic)
                }
                
            }
        }
    }
}
