//
//  SettingView.swift
//  Duas
//
//  Created by Ishraq on 9/7/18.
//  Copyright © 2018 Duas. All rights reserved.
//

import UIKit

class SettingView: UIView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var colorOptionViews: [UIView]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        let nib = UINib(nibName: "SettingsView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        colorOptionViews.forEach { (colorView) in
            colorView.layer.cornerRadius = colorView.frame.size.width/2
            colorView.layer.masksToBounds = true
            
            colorView.layer.borderColor = UIColor.black.cgColor
            colorView.layer.borderWidth = 2.0
        }
        
    }

}
