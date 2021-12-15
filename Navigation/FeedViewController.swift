//
//  FeedViewController.swift
//  Navigation
//
//  Created by Евгения Шевякова on 01.12.2021.
//

import UIKit

class FeedViewController: UIViewController {
    
    let buttonWidth: CGFloat = 160
    let buttonHeight: CGFloat = 44
    let post = Post(title: "Пост")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let x: CGFloat = (view.bounds.width / 2) - (buttonWidth / 2)
        let y: CGFloat = (view.bounds.height / 2) - (buttonHeight / 2)
        
        let buttonFrame = CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)
        let transitionButton = UIButton(frame: buttonFrame)
        transitionButton.backgroundColor = .systemBlue
        transitionButton.layer.cornerRadius = 14
        transitionButton.setTitle("Открыть пост", for: .normal)
        transitionButton.setTitleColor(.white, for: .normal)
        transitionButton.addTarget(self, action: #selector(transitionButtonTapped), for: .touchUpInside)
        
        view.addSubview(transitionButton)
        
        view.backgroundColor = .white

    }
    
    @objc
    func transitionButtonTapped() {
        let vc = PostViewController()
        vc.post = self.post
        navigationController?.pushViewController(vc, animated: true)
    }
    
   
    
    
}
