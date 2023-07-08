//
//  BrutForceHelper.swift
//  Navigation
//
//  Created by Евгения Шевякова on 08.07.2023.
//

import Foundation

final class BrutForceHelper {
    func randomString(length: Int) -> String {
        let letters = String().digitsAndLetters
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }
    
    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
                                   : Character("")
    }
}

extension String {
    var digits:             String { return "0123456789" }
    var lowercase:          String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:          String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation:        String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:            String { return lowercase + uppercase }
    var printable:          String { return digits + letters + punctuation }
    var digitsAndLetters:   String { return digits + letters }


    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
