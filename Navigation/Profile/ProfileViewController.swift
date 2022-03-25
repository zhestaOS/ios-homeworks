//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Евгения Статива on 28.11.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.toAutoLayout()
        
        return view
    }()
        
    private var postArray: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationController?.navigationBar.isTranslucent = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        
//        tableView.tableHeaderView = ProfileTableHeaderView()
        tableView.tableFooterView = UIView()
        
        let post1 = Post(
            author: "lingva.ru",
            image: "mountains",
            description: "Далеко-далеко за словесными горами в стране гласных и согласных живут рыбные тексты. Вдали от всех живут они в буквенных домах на берегу Семантика большого языкового океана.",
            likes: 243,
            views: 365
        )
        let post2 = Post(
            author: "Иоганн Вольфганг Гёте",
            image: "goethe",
            description: "Душа моя озарена неземной радостью, как эти чудесные весенние утра, которыми я наслаждаюсь от всего сердца. Я совсем один и блаженствую в здешнем краю, словно созданном для таких, как я.",
            likes: 276,
            views: 470
        )
        let post3 = Post(
            author: "Франц Кафка",
            image: "kafka",
            description: "Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил, что он у себя в постели превратился в страшное насекомое.",
            likes: 132,
            views: 265
        )
        let post4 = Post(
            author: "Александр Дюма",
            image: "dumas",
            description: "Посмотрите, — сказал аббат, — на солнечный луч, проникающий в мое окно, и на эти линии, вычерченные мною на стене. По этим линиям я определяю время вернее, чем если бы у меня были часы, потому что часы могут испортиться, а солнце и земля всегда работают исправно.",
            likes: 344,
            views: 368
        )
        
        postArray = [post1, post2, post3, post4]
        tableView.reloadData()
    
        addSubviews()
        setConstraints()
     
    }
    
    private func addSubviews() {
        view.addSubviews(
            tableView
        )
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

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath)
        
        if let cell = cell as? PostTableViewCell {
            cell.update(with: postArray[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        570
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ProfileTableHeaderView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }
}
