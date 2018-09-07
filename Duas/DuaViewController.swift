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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(onPinch(_:)))
        duaView.delegate = self
        dua = allDuas[0]
        prevDua = dua
        duaView.dua = dua
        duaView.addGestureRecognizer(pinchRecognizer)
        title = dua?.arabicName
        
        // FIXME: - load font size, and contentOffset
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if prevDua != dua {
            duaView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            duaView.dua = dua
            title = dua?.arabicName
            prevDua = dua
        }
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
            duaView.zoomTo(fontSize: adjustedFontSize)
        // FIXME: - save new font size
        default:
            break
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating contentOffset: \(scrollView.contentOffset)")
        // FIXME: - save content offset
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            print("scrollViewDidEndDragging contentOffset: \(scrollView.contentOffset)")
            // FIXME: - save content offset
        }
    }
    
    func didSelectDua(_ dua: Dua) {
        if prevDua != dua {
            self.dua = dua
        }
    }
        
}

