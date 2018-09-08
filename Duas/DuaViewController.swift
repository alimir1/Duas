//
//  ViewController.swift
//  
//
//  Created by Ishraq on 9/5/18.
//  Copyright © 2018 Ali. All rights reserved.
//

import UIKit

class DuaViewController: UIViewController, DuaSelectionDelegate, SettingViewDelegate {
    
    @IBOutlet private var duasButtonItem: UIBarButtonItem!
    @IBOutlet var duaView: DuaView!
    @IBOutlet private var settingsView: SettingView!
    
    var dua: Dua? {
        didSet {
            duaView.dua = dua
            title = dua?.arabicName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dua = allDuas[UserDefaults.standard.integer(forKey: "PreviouslyViewedDuaNumber")]
        settingsView.layer.cornerRadius = 20
        settingsView.layer.masksToBounds = true
        settingsView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // save contentOffset
        UserDefaults.standard.set(Float(duaView.textView.contentOffset.y), forKey: "DuaVCContentOffsetY")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateThemeView()
    }
    
    private func updateThemeView() {
        navigationController?.navigationBar.barTintColor = ThemeManager.currentTheme.secondaryColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ThemeManager.currentTheme.navBarTintColor]
        view.backgroundColor = ThemeManager.currentTheme.backgroundColor
        duaView.scrollIndicatorView.backgroundColor = ThemeManager.currentTheme.mainColor
        duaView.textView.backgroundColor = ThemeManager.currentTheme.backgroundColor
        duaView.textView.textColor = ThemeManager.currentTheme.textColor
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
    
    func settingView(_ settingView: SettingView, didUpdateTheme theme: Theme) {
        ThemeManager.applyTheme(theme: theme)
        updateThemeView()
    }
    
    @IBAction private func onFilterTap() {
        settingsView.isHidden = !settingsView.isHidden
    }
        
}

