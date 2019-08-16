//
//  LocalizedString.swift
//  iOS-Localize
//
//  Created by Denis Svichkarev on 16/08/2019.
//  Copyright © 2019 Denis Svichkarev. All rights reserved.
//

import Cocoa

extension Character {
    var isUppercase: Bool {
        let str = String(self)
        return str == str.uppercased()
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}


class LocalizedString: NSObject {
    
    var isCorrectString: Bool = false
    var isFirstLetterCapital: Bool = false
    
    var originalValue: String = ""
    var leftValue: String = ""
    var rightValue: String = ""
    
    init(original: String) {
        super.init()
        
        self.originalValue = original
        self.checkIfCorrect()
    }
    
    func checkIfCorrect() {
        let segments = originalValue.components(separatedBy: "\"")
        if segments.count == 5 {
            isCorrectString = true
            leftValue = segments[1]
            rightValue = segments[3]
            
            if let first = segments[3].first, first.isUppercase {
                isFirstLetterCapital = true
            }
        }
        //print(segments)
    }
    
    func getFinalString() -> String {
        if isCorrectString {
            if isFirstLetterCapital {
                rightValue = rightValue.capitalizingFirstLetter()
            }
            return "\"" + leftValue + "\" = \"" + rightValue + "\";"
        } else {
            return originalValue
        }
    }
}
