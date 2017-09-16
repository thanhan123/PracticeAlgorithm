//
//  CodeFightsTest.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 9/13/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class CodeFightsTest {
    func firstDuplicate(_ a: [Int]) -> Int {
        var occuranceArray = [Int](repeating: 0, count: a.count + 1)
        for i in 0..<a.count {
            let number = a[i]
            if occuranceArray[number] == 1 {
                return number
            }
            occuranceArray[number] = occuranceArray[number] + 1
        }
        
        return -1
    }
    
    func firstNotRepeatingCharacter(s: String) -> Character {
        var uniqueCharacterString = ""
        var repeatedCharacterString = ""
        for c in s.characters {
            if !uniqueCharacterString.contains("\(c)") {
                uniqueCharacterString = uniqueCharacterString.appending("\(c)")
            } else if !repeatedCharacterString.contains("\(c)"){
                repeatedCharacterString = repeatedCharacterString.appending("\(c)")
            }
        }
        
        for c in repeatedCharacterString.characters {
            uniqueCharacterString = uniqueCharacterString.replacingOccurrences(of: "\(c)", with: "")
        }
        
        return uniqueCharacterString.characters.count > 0 ? uniqueCharacterString.characters.first! : "_"
    }
    
    func isCryptSolution(crypt: [String], solution: [[Character]]) -> Bool {
        var solutionDict = [String: String]()
        
        for s in solution {
            solutionDict["\(s[0])"] = "\(s[1])"
        }
        
        var encryptedArray = [Int]()
        
        for c in crypt {
            let encryptString = encrypt(s: c, solution: solutionDict)
            if encryptString[encryptString.startIndex] == "0" && encryptString.characters.count > 1 {
                return false
            }
            encryptedArray.append(Int("\(encryptString)")!)
        }
        
        return encryptedArray[0] + encryptedArray[1] == encryptedArray[2]
    }
    
    internal func encrypt(s: String, solution: [String: String]) -> String {
        var result = ""
        for c in s.characters {
            result = result.appending(solution["\(c)"]!)
        }
        
        return result
    }
}
