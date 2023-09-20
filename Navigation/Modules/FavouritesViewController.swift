//
//  FavouritesViewController.swift
//  Navigation
//
//  Created by Евгения Шевякова on 20.09.2023.
//

import UIKit
import StorageService

class FavouritesViewController: UITableViewController {
    
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        posts = CoreDataManager.shared.posts()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath)

        if let cell = cell as? PostTableViewCell {
            cell.update(with: posts[indexPath.row])
        }
        return cell
    }
}
