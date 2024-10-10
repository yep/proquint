//
//  ProquintModel.swift
//  Proquint
//
//  Created by # on 13.12.21.
//

import Foundation

struct ProquintModel {
    var proquint  = ""
    var wordCount: Int {
        didSet {
            generateProquint()
        }
    }

    mutating func generateProquint() {
        let consonants = ["b", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "r", "s", "t", "v", "z"]
        let vowels = ["a", "i", "o", "u"]
        var result = ""

        for i in 1 ... wordCount {
            let n = Int.random(in: 0...0xFFFF)
            let consonant1 =  n        & 0x0f
            let vowel1     = (n >> 4)  & 0x03
            let consonant2 = (n >> 6)  & 0x0f
            let vowel2     = (n >> 10) & 0x03
            let consonant3 = (n >> 12) & 0x0f
            
            result += consonants[consonant1] + vowels[vowel1] +
                      consonants[consonant2] + vowels[vowel2] +
                      consonants[consonant3] + " "
            
            if i == (wordCount + 1) / 2 {
                result += "\n"
            }
        }
        
        proquint = result
    }
}
