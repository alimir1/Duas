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
    let category: String
    
    init(englishName: String, arabicName: String, text: String, category: String) {
        self.englishName = englishName
        self.arabicName = arabicName
        self.text = text
        self.category = category
    }
    
    static func ==(lhs: Dua, rhs: Dua) -> Bool {
        return lhs.englishName == rhs.englishName
    }
}

let allDuas: [Dua] = [
    Dua(englishName: "Dua Kumayl", arabicName: "دعاء کمیل", text: DuaTexts.kumayl, category: "Regular"),
    Dua(englishName: "Dua Mashlool", arabicName:"دعاء المشلول", text: DuaTexts.mashlool, category: "Regular"),
    Dua(englishName: "Dua Tawassul", arabicName: "دعاء تَوَسّولْ", text: DuaTexts.tawassul, category: "Regular"),
    Dua(englishName: "Dua Ahad", arabicName: "دعاء عَهْد", text: DuaTexts.kumayl, category: "Regular"),
    Dua(englishName: "Dua Sabah", arabicName: "دعاء الصباح", text: DuaTexts.kumayl, category: "Regular"),
    Dua(englishName: "Dua Adeelah", arabicName: "دعاء عديلا", text: DuaTexts.kumayl, category: "Regular"),
    Dua(englishName: "Dua Faraj", arabicName: "دعاء فرج", text: DuaTexts.kumayl, category: "Regular"),
    Dua(englishName: "Fajr", arabicName: "الفجر", text: DuaTexts.kumayl, category: "Daily Prayer"),
    Dua(englishName: "Dhuhr", arabicName: "الظهر", text: DuaTexts.kumayl, category: "Daily Prayer"),
    Dua(englishName: "Asr", arabicName: "العصر", text: DuaTexts.kumayl, category: "Daily Prayer"),
    Dua(englishName: "Maghrib ", arabicName: "المغرب", text: DuaTexts.kumayl, category: "Daily Prayer"),
    Dua(englishName: "Isha", arabicName: "العشاء", text: DuaTexts.kumayl, category: "Daily Prayer"),
    Dua(englishName: "Saturday", arabicName: "السبت", text: DuaTexts.kumayl, category: "Days Of The Week"),
    Dua(englishName: "Sunday", arabicName: "الأحد", text: DuaTexts.kumayl, category: "Days Of The Week"),
    Dua(englishName: "Monday", arabicName: "الأثنين", text: DuaTexts.kumayl, category: "Days Of The Week"),
    Dua(englishName: "Tuesday", arabicName: "الثلاثاء", text: DuaTexts.kumayl, category: "Days Of The Week"),
    Dua(englishName: "Wednesday", arabicName: "الأربعاء", text: DuaTexts.kumayl, category: "Days Of The Week"),
    Dua(englishName: "Thursday", arabicName: "الخميس", text: DuaTexts.kumayl, category: "Days Of The Week"),
    Dua(englishName: "Friday", arabicName: "الجمعه", text: DuaTexts.kumayl, category: "Days Of The Week"),
]
