//
//  PostViewController.swift
//  Navigation
//
//  Created by Евгения Шевякова on 01.12.2021.
//

import UIKit
import StorageService

final class PostViewController: UIViewController {
    
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        
        let infoBarButton = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoBarButtonTapped))
        navigationItem.rightBarButtonItem = infoBarButton
        
    }
    
    @objc
    func infoBarButtonTapped() {
        let vc = InfoViewController()
        present(vc, animated: true)
    }
}

