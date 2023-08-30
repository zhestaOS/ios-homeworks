//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Евгения Статива on 28.11.2021.
//

import UIKit
import StorageService

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
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = PhotosViewController()
        nextVC.update(title: "Photo Gallery")
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
