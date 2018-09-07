//
//  Dua.swift
//  Duas
//
//  Created by Ishraq on 9/6/18.
//  Copyright © 2018 Duas. All rights reserved.
//

import Foundation

class Dua: Equatable, Hashable {
    
    let englishName: String
    let arabicName: String
    let text: String
    let category: String
    let index: Int
    
    init(englishName: String, arabicName: String, text: String, category: String, index: Int) {
        self.englishName = englishName
        self.arabicName = arabicName
        self.text = text
        self.category = category
        self.index = index
    }
    
    static func ==(lhs: Dua, rhs: Dua) -> Bool {
        return lhs.englishName == rhs.englishName
    }
    
    var hashValue: Int {
        return englishName.hashValue ^ arabicName.hashValue ^ category.hashValue
    }
}

let allDuas: [Dua] = [
    Dua(englishName: "Dua Kumayl", arabicName: "دعاء کمیل", text: DuaTexts.kumayl, category: "Regular", index: 0),
    Dua(englishName: "Dua Mashlool", arabicName:"دعاء المشلول", text: DuaTexts.mashlool, category: "Regular", index: 1),
    Dua(englishName: "Dua Tawassul", arabicName: "دعاء تَوَسّولْ", text: DuaTexts.tawassul, category: "Regular", index: 2),
    Dua(englishName: "Dua Ahad", arabicName: "دعاء عَهْد", text: DuaTexts.ahad, category: "Regular", index: 3),
    Dua(englishName: "Dua Sabah", arabicName: "دعاء الصباح", text: DuaTexts.sabah, category: "Regular", index: 4),
    Dua(englishName: "Dua Faraj", arabicName: "دعاء فرج", text: DuaTexts.faraj, category: "Regular", index: 5),
    Dua(englishName: "Fajr", arabicName: "الفجر", text: DuaTexts.fajr, category: "Daily Prayer", index: 6),
    Dua(englishName: "Dhuhr", arabicName: "الظهر", text: DuaTexts.dhuhr, category: "Daily Prayer", index: 7),
    Dua(englishName: "Asr", arabicName: "العصر", text: DuaTexts.asr, category: "Daily Prayer", index: 8),
    Dua(englishName: "Maghrib ", arabicName: "المغرب", text: DuaTexts.maghrib, category: "Daily Prayer", index: 9),
    Dua(englishName: "Isha", arabicName: "العشاء", text: DuaTexts.isha, category: "Daily Prayer", index: 10),
    Dua(englishName: "Saturday", arabicName: "السبت", text: DuaTexts.saturday, category: "Days Of The Week", index: 11),
    Dua(englishName: "Sunday", arabicName: "الأحد", text: DuaTexts.sunday, category: "Days Of The Week", index: 12),
    Dua(englishName: "Monday", arabicName: "الأثنين", text: DuaTexts.monday, category: "Days Of The Week", index: 13),
    Dua(englishName: "Tuesday", arabicName: "الثلاثاء", text: DuaTexts.tuesday, category: "Days Of The Week", index: 14),
    Dua(englishName: "Wednesday", arabicName: "الأربعاء", text: DuaTexts.wednesday, category: "Days Of The Week", index: 15),
    Dua(englishName: "Thursday", arabicName: "الخميس", text: DuaTexts.thursday, category: "Days Of The Week", index: 16),
    Dua(englishName: "Friday", arabicName: "الجمعه", text: DuaTexts.friday, category: "Days Of The Week", index: 17),
]
