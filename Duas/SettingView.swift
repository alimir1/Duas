//
//  SettingView.swift
//  Duas
//
//  Created by Ishraq on 9/7/18.
//  Copyright © 2018 Duas. All rights reserved.
//

import UIKit

protocol SettingViewDelegate: class {
    func settingView(_ settingView: SettingView, didUpdateTheme theme: Theme)
}

class SettingView: UIView {
    
    @IBOutlet var colorsStackView: UIStackView!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var colorOptionViews: [UIView]!
    
    var delegate: SettingViewDelegate?
    
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
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onColorTap(_:)))
            colorView.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    @objc private func onColorTap(_ gesture: UITapGestureRecognizer) {
        let pressedLoc = gesture.location(in: colorsStackView)
        let hitTestView = colorsStackView.hitTest(pressedLoc, with: nil)
        if let hitView = hitTestView, let theme = Theme(rawValue: hitView.tag) {
            delegate?.settingView(self, didUpdateTheme: theme)
        }
    }

}
