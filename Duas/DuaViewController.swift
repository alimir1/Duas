//
//  ViewController.swift
//  
//
//  Created by Ishraq on 9/5/18.
//  Copyright © 2018 Ali. All rights reserved.
//

import UIKit

class DuaViewController: UIViewController, DuaSelectionDelegate {
    
    @IBOutlet var duasButtonItem: UIBarButtonItem!
    @IBOutlet var duaView: DuaView!
    @IBOutlet var settingsView: SettingView!
        
    var dua: Dua? {
        didSet {
            duaView.dua = dua
            title = dua?.arabicName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dua = allDuas[UserDefaults.standard.integer(forKey: "PreviouslyViewedDuaNumber")]
        view.backgroundColor = UIColor(red:0.98, green:0.96, blue:0.95, alpha:1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red:0.99, green:0.98, blue:0.96, alpha:1.0)
        settingsView.layer.cornerRadius = 20
        settingsView.layer.masksToBounds = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // save contentOffset
        UserDefaults.standard.set(Float(duaView.textView.contentOffset.y), forKey: "DuaVCContentOffsetY")
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "duaListSegue" {
            let vc = segue.destination as! DuasListViewController
            vc.delegate = self
        }
    }
    
    func didSelectDua(_ dua: Dua) {
        self.dua = dua
        // save selected dua
        UserDefaults.standard.set(dua.index, forKey: "PreviouslyViewedDuaNumber")
    }
    
    @IBAction func onFilterTap() {
        settingsView.isHidden = !settingsView.isHidden
    }
        
}

