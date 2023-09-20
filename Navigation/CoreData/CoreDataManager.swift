//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Евгения Шевякова on 20.09.2023.
//

import UIKit
import CoreData
import StorageService

class CoreDataManager: NSObject {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func savePost(post: Post) {
        let postDB = PostDB(context: persistentContainer.viewContext)
        postDB.author = post.author
        postDB.image = post.image
        postDB.textValue = post.textValue
        postDB.likes = Int32(post.likes)
        postDB.views = Int32(post.views)
        saveContext()
    }
    
    func posts() -> [Post] {
        return try! persistentContainer.viewContext.fetch(PostDB.fetchRequest()).map({ db in
            Post(
                author: db.author ?? "",
                image: db.image ?? "",
                description: db.textValue ?? "",
                likes: Int(db.likes),
                views: Int(db.views)
            )
        })
    }
}
