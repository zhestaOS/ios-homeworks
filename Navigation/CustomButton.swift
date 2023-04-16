//
//  CustomButton.swift
//  Navigation
//
//  Created by Евгения Шевякова on 25.03.2023.
//

import UIKit

final class CustomButton: UIButton {
    
    private var title: String?
    private var сolorOfBackground: UIColor?
    var tapAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String?, сolorOfBackground: UIColor?) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        backgroundColor = сolorOfBackground
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupButton() {
        titleLabel?.textColor   = .white
        titleLabel?.font        = .systemFont(ofSize: 18)
        layer.cornerRadius      = 14
        layer.shadowOffset      = CGSize(width: 4, height: 4)
        layer.shadowRadius      = 4
        layer.shadowColor       = UIColor.black.cgColor
        layer.shadowOpacity     = 0.7
        addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        toAutoLayout()
    }
    
    @objc
    func tapped() {
        tapAction?()
    }
    
}
