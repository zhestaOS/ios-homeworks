//
//  FavouritesViewController.swift
//  Navigation
//
//  Created by Евгения Шевякова on 20.09.2023.
//

import UIKit
import StorageService
import CoreData

class FavouritesViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var fetchResultController: NSFetchedResultsController<PostDB>?
    
    var searchValue: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "favs_search_button".localized, style: .plain, target: self, action: #selector(sesrchTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "favs_clear_button".localized, style: .plain, target: self, action: #selector(clearTapped))
        
        fetchResultController = setupFetchController()
    }
    
    func setupFetchController() -> NSFetchedResultsController<PostDB> {
        let fetchRequest = PostDB.fetchRequest()
        if searchValue != nil {
            fetchRequest.predicate = NSPredicate(format: "author CONTAINS %@", searchValue!)
        }
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "addedAt", ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        try? frc.performFetch()
        return frc
    }
    
    @objc
    func sesrchTapped() {
        let alertController = UIAlertController(title: "favs_search_enter_author_label".localized, message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "favs_search_enter_author_placeholder".localized
        })
        alertController.addAction(UIAlertAction(title: "cancel".localized, style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "search".localized, style: .default, handler: { [weak self] alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            guard let text = textField.text, !text.isEmpty else {
                return
            }
            self?.searchValue = text
            self?.fetchResultController = self?.setupFetchController()
            self?.tableView.reloadData()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc
    func clearTapped() {
        searchValue = nil
        fetchResultController = nil
        fetchResultController = setupFetchController()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultController?.sections?[section].numberOfObjects ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath)
        let post = fetchResultController?.object(at: indexPath)
        if let cell = cell as? PostTableViewCell {
            cell.update(with: post!.convert())
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let postDB = fetchResultController?.object(at: indexPath) {
                CoreDataManager.shared.delete(post: postDB)
            }
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}

extension PostDB {
    func convert() -> Post {
        Post(
            author: author ?? "",
            image: UIImage(named: image ?? ""),
            imageName: image ?? "",
            description: textValue ?? "",
            likes: Int(likes),
            views: Int(views)
        )
    }
}
