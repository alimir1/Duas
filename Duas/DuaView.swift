//
//  DuaView.swift
//  Duas
//
//  Created by Ishraq on 9/6/18.
//  Copyright © 2018 Duas. All rights reserved.
//

import UIKit

class DuaView: UIView, UITextViewDelegate {
    
    private var maxSize: CGFloat = 200
    private var minSize: CGFloat = 10
    private var isFirstTime = true
    
    private var fontSize: CGFloat = 40 {
        didSet {
            textView.font = UIFont(name: "Scheherazade-Regular", size: fontSize)
        }
    }
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var scrollIndicatorView: UIView!
    @IBOutlet private var scrollViewIndicatorHeightConstraint: NSLayoutConstraint!
    @IBOutlet var textView: UITextView!
    
    var dua: Dua? {
        didSet {
            if oldValue != dua {
                textView.text = dua?.text
                if !isFirstTime {
                    textView.contentOffset.y = 0
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !textView.isScrollEnabled {
            textView.isScrollEnabled = true
        }
        if isFirstTime {
            let offsetY: CGFloat = CGFloat(UserDefaults.standard.float(forKey: "DuaVCContentOffsetY"))
            textView.contentOffset.y = offsetY
            isFirstTime = false
        }
    }
    
    func setup() { 
        
        let nib = UINib(nibName: "DuaView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        textView.isScrollEnabled = false
        
        scrollIndicatorView.backgroundColor = .brown
        
        textView.delegate = self
        textView.font = UIFont(name: "Scheherazade-Regular", size: fontSize)
        textView.scrollsToTop = false
        textView.isEditable = false
        textView.textAlignment = .right
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 10)
        backgroundColor = UIColor(red:0.98, green:0.96, blue:0.95, alpha:1.0)
        textView.backgroundColor = UIColor(red:0.98, green:0.96, blue:0.95, alpha:1.0)
        
        
        // load font size
        let savedFontSize = UserDefaults.standard.float(forKey: "DuaVCFontSize")
        if savedFontSize > 0 { zoomTo(fontSize: CGFloat(savedFontSize)) }
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(onPinch(_:)))
        addGestureRecognizer(pinchRecognizer)
    }
    
    // MARK: - Pinch
    
    var adjustedFontSize: CGFloat = 0.0
    
    @objc func onPinch(_ sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .began:
            adjustedFontSize = textView.font?.pointSize ?? 20
        case .changed:
            adjustedFontSize += (sender.velocity > 0 ? 1 : -1)
            self.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
        case .ended:
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            let newSize = self.zoomTo(fontSize: adjustedFontSize)
            fontSize = newSize
            // save new font size
            UserDefaults.standard.set(Float(newSize), forKey: "DuaVCFontSize")
        default:
            break
        }
    }
    
    // MARK: - Scrolling and Zooming
    
    private func resetScrollViewIndicatorHeight() {
        let height = ((textView.contentOffset.y+frame.size.height)/textView.contentSize.height)*frame.size.height
        scrollViewIndicatorHeightConstraint.constant = height
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        resetScrollViewIndicatorHeight()
    }
    
    @discardableResult
    func zoomTo(fontSize: CGFloat) -> CGFloat {
        var size = fontSize
        if size < minSize { size = minSize }
        else if size > maxSize { size = maxSize }
        textView.font = UIFont(name: "Scheherazade-Regular", size: size)
        return size
    }
}
