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
    var searchValue: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "search", style: .plain, target: self, action: #selector(sesrchTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "clear", style: .plain, target: self, action: #selector(clearTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        posts = CoreDataManager.shared.posts()
        tableView.reloadData()
    }
    
    @objc
    func sesrchTapped() {
        let alertController = UIAlertController(title: "Enter author", message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Search author..."
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Search", style: .default, handler: { [weak self] alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            guard let text = textField.text, !text.isEmpty else {
                return
            }
            self?.searchValue = text
            self?.updatePosts()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc
    func clearTapped() {
        searchValue = nil
        posts = CoreDataManager.shared.posts()
        tableView.reloadData()
    }

    func updatePosts() {
        guard let searchValue else {
            return
        }
        posts.removeAll()
        posts = CoreDataManager.shared.searchAuthor(author: searchValue)
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            CoreDataManager.shared.delete(post: posts[indexPath.row])
            posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}
