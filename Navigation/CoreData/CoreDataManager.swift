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
        container.viewContext.automaticallyMergesChangesFromParent = true
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
        let context = persistentContainer.newBackgroundContext()
        let postDB = PostDB(context: context)
        postDB.author = post.author
        postDB.image = post.image
        postDB.textValue = post.textValue
        postDB.likes = Int32(post.likes)
        postDB.views = Int32(post.views)
        postDB.addedAt = Date()
        try? context.save()
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
    
    func delete(post: PostDB) {
        let backgroundContext = persistentContainer.newBackgroundContext()
        let postDB = backgroundContext.object(with: post.objectID)
        
        backgroundContext.delete(postDB)
        try? backgroundContext.save()
    }
    
    func searchAuthor(author: String) -> [Post] {
        let backgroundContext = persistentContainer.newBackgroundContext()
        
        let predicate = NSPredicate(format: "author CONTAINS %@", author)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostDB")
        fetchRequest.predicate = predicate
        let posts = try? backgroundContext.fetch(fetchRequest) as? [PostDB]
        
        guard let posts = posts else { return [] }
        
        return posts.map { db in
            return Post(
                author: db.author ?? "",
                image: db.image ?? "",
                description: db.textValue ?? "",
                likes: Int(db.likes),
                views: Int(db.views)
            )
        }
    }
}
