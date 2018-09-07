//
//  ViewController.swift
//  Triplebyte
//
//  Created by Ishraq on 9/5/18.
//  Copyright © 2018 Ali. All rights reserved.
//

import UIKit

class DuaViewController: UIViewController, UITextViewDelegate, DuaSelectionDelegate {
    
    @IBOutlet var duaView: DuaView!
    var adjustedFontSize: CGFloat = 0.0
    var prevDua: Dua?
    var dua: Dua?
    
    var customIndicator: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(onPinch(_:)))
        duaView.delegate = self
        dua = allDuas[UserDefaults.standard.integer(forKey: "PreviouslyViewedDuaNumber")]
        prevDua = dua
        duaView.dua = dua
        duaView.addGestureRecognizer(pinchRecognizer)
        title = dua?.arabicName
        
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
        customIndicator = UIView(frame: CGRect(x: view.frame.width - 3, y: navBarHeight, width: 3, height: 0))
        customIndicator.backgroundColor = .red
        
        view.addSubview(customIndicator)
        
        // load font size, and contentOffset
        let fontSize = UserDefaults.standard.float(forKey: "DuaVCFontSize")
        let contentOffset = UserDefaults.standard.float(forKey: "DuaVCContentOffsetY")
        if fontSize > 0 { duaView.zoomTo(fontSize: CGFloat(fontSize)) }
        if contentOffset > 0 { 
            duaView.contentOffset.y = CGFloat(contentOffset)  
            refreshScrollIndicator(for: view.frame.size)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        refreshScrollIndicator(for: size)
        duaView.isScrollEnabled = false
    }
    
    func refreshScrollIndicator(for size: CGSize) {
        guard let customIndicator = customIndicator else { return }
        var navBarHeight: CGFloat = (navigationController?.navigationBar != nil ? 30 : 8)
        if UIDevice.current.orientation.isPortrait {
            navBarHeight = navigationController?.navigationBar.frame.height ?? 0
        }
        let height = ((duaView.contentOffset.y+size.height-navBarHeight)/duaView.contentSize.height)*(size.height-navBarHeight)
        customIndicator.frame = CGRect(x: size.width - customIndicator.frame.width, y: navBarHeight, width: customIndicator.frame.width, height: height)
        duaView.isScrollEnabled = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshScrollIndicator(for: view.frame.size)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if prevDua != dua {
            duaView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            duaView.dua = dua
            title = dua?.arabicName
            prevDua = dua
        }
        refreshScrollIndicator(for: view.frame.size)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "duaListSegue" {
            let vc = segue.destination as! DuasListViewController
            vc.delegate = self
        }
    }
    
    @objc func onPinch(_ sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .began:
            adjustedFontSize = duaView.font?.pointSize ?? 25
        case .changed:
            adjustedFontSize += (sender.velocity > 0 ? 1 : -1)
            duaView.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
        case .ended:
            duaView.transform = CGAffineTransform(scaleX: 1, y: 1)
            duaView.zoomScale = 1.0
            let newSize = duaView.zoomTo(fontSize: adjustedFontSize)
        // save new font size
            UserDefaults.standard.set(Float(newSize), forKey: "DuaVCFontSize")
        default:
            break
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // save content offset
        UserDefaults.standard.set(Float(scrollView.contentOffset.y), forKey: "DuaVCContentOffsetY")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            // save content offset
            UserDefaults.standard.set(Float(scrollView.contentOffset.y), forKey: "DuaVCContentOffsetY")
        }
    }
    
    func didSelectDua(_ dua: Dua) {
        if prevDua != dua {
            self.dua = dua
            // save selected dua
            UserDefaults.standard.set(dua.index, forKey: "PreviouslyViewedDuaNumber")
        }
    }
        
}

