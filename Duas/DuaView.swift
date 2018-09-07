//
//  DuaView.swift
//  Duas
//
//  Created by Ishraq on 9/6/18.
//  Copyright © 2018 Duas. All rights reserved.
//

import UIKit

class DuaView: UITextView {
    
    private var maxSize: CGFloat = 200
    private var minSize: CGFloat = 10
    
    var dua: Dua? {
        didSet {
            text = dua?.text
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        font = UIFont(name: "Scheherazade-Regular", size: 40)
        scrollsToTop = false
        isEditable = false
        textAlignment = .right
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        textContainerInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 8)
    }
    
    @discardableResult
    func zoomTo(fontSize: CGFloat) -> CGFloat {
        var size = fontSize
        if size < minSize { size = minSize }
        else if size > maxSize { size = maxSize }
        font = UIFont(name: "Scheherazade-Regular", size: size)
        return size
    }
}
