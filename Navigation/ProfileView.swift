//
//  ProfileView.swift
//  Navigation
//
//  Created by Евгения Статива on 27.11.2021.
//

import UIKit

class ProfileView: UIView {

    @IBOutlet weak var userFoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var cityOfBirth: UILabel!
    @IBOutlet weak var userDescription: UITextView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let xibView = Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)!.first as! UIView
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
}
