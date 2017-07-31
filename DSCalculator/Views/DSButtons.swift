//
//  DSButtons.swift
//  DSCalculator
//
//  Created by Mac on 27.07.17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import UIKit

class DSButtons: UIButton {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setButton()
    }
    
    func setButton() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.lightGray.cgColor

    }
}
