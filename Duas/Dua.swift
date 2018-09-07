//
//  Dua.swift
//  Duas
//
//  Created by Ishraq on 9/6/18.
//  Copyright © 2018 Duas. All rights reserved.
//

import Foundation

class Dua: Equatable {
    let englishName: String
    let arabicName: String
    let text: String
    
    init(englishName: String, arabicName: String, text: String) {
        self.englishName = englishName
        self.arabicName = arabicName
        self.text = text
    }
    
    static func ==(lhs: Dua, rhs: Dua) -> Bool {
        return lhs.englishName == rhs.englishName
    }
}

let allDuas: [Dua] = [
    Dua(englishName: "Kumayl", arabicName: "دعا کمیل", text: DuaTexts.kumayl),
    Dua(englishName: "Mashlool", arabicName: "مشلول", text: DuaTexts.kumayl)
]
