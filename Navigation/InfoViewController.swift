//
//  InfoViewController.swift
//  Navigation
//
//  Created by Евгения Шевякова on 02.12.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    let buttonWidth: CGFloat = 200
    let buttonHeight: CGFloat = 44

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let x: CGFloat = (view.bounds.width / 2) - (buttonWidth / 2)
        let y: CGFloat = (view.bounds.height / 2) - (buttonHeight / 2)
        
        let buttonFrame = CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)
        let alertButton = UIButton(frame: buttonFrame)
        alertButton.backgroundColor = .systemTeal
        alertButton.setTitle("Предупреждение", for: .normal)
        alertButton.setTitleColor(.white, for: .normal)
        alertButton.addTarget(self, action: #selector(alertButtonTapped), for: .touchUpInside)
        
        view.addSubview(alertButton)
        
        view.backgroundColor = .white

    }
    
    @objc
    func alertButtonTapped() {
        let alertController = UIAlertController(title: "Предупреждение", message: "Вы уверены, что хотите продолжить?", preferredStyle: .alert)
        let yesAlert = UIAlertAction(title: "Да", style: .default) { action in
            print("Да, я хочу продолжить")
        }
        let noAlert = UIAlertAction(title: "Нет", style: .default) { action in
            print("Нет, я не хочу продолжать")
        }
        
        alertController.addAction(yesAlert)
        alertController.addAction(noAlert)

        present(alertController, animated: true)
        
    }
}
