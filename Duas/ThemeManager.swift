//
//  ThemeManager.swift
//  Duas
//
//  Created by Ishraq on 9/8/18.
//  Copyright © 2018 Duas. All rights reserved.
//

import UIKit
import Foundation

enum Theme: Int {
    
    case brown, red, green, black, white
    
    var mainColor: UIColor {
        switch self {
        case .brown: return .brown
        case .red: return .red
        case .black: return .black
        case .white: return .white
        case .green: return UIColor(red:0.01, green:0.53, blue:0.00, alpha:1.0)
        }
    }
    
    var navBarTintColor: UIColor {
        if self == .black { return .white }
        if self == .white { return .black }
        return mainColor
    }
    
    var textColor: UIColor {
        if self == .black { return .white }
        return .black
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .brown:
            return UIColor(red:0.98, green:0.96, blue:0.95, alpha:1.0)
        case .red:
            return UIColor(red:1.00, green:0.97, blue:0.97, alpha:1.0)
        case .black:
            return .black
        case .white:
            return .white
        case .green:
            return UIColor(red:0.97, green:1.00, blue:0.97, alpha:1.0)
        }
    }
    
    var scrollIndicatorColor: UIColor {
        if self == .black { return .white }
        if self == .white { return .black }
        return mainColor
    }
    
    var secondaryColor: UIColor {
        switch self {
        case .brown:
            return UIColor(red:1.00, green:0.99, blue:0.99, alpha:1.0)
        case .red:
            return UIColor(red:1.00, green:0.99, blue:0.99, alpha:1.0)
        case .black:
            return .black
        case .white:
            return .white
        case .green:
            return UIColor(red:0.99, green:1.00, blue:0.99, alpha:1.0)
        }
    }
}

// Enum declaration
let SelectedThemeKey = "SelectedTheme"

// This will let you use a theme in the app.
class ThemeManager {
    
    // ThemeManager
    static var currentTheme: Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .brown
        }
    }
    
    static func applyTheme(theme: Theme) {
        // First persist the selected theme using UserDefaults.
        UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
        UserDefaults.standard.synchronize()
        
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.navBarTintColor
        sharedApplication.statusBarStyle = (theme == .black ? .lightContent : .default) 
    }
}
