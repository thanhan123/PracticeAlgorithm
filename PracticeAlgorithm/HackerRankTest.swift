//
//  HackerRankTest.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 9/18/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class HackerRank {
    func leftRotationArray(_ a: inout [Int], _ d: Int) -> [Int] {
        
        // readLine()!.components(separatedBy: " ").map { Int($0)! }
        
        reverseArray(&a, 0, d - 1)
        reverseArray(&a, d, a.count - 1)
        reverseArray(&a, 0, a.count - 1)
        
        print(a.map({ String($0) }).joined(separator: " "))
        
        return a
    }
    
    internal func reverseArray(_ a: inout [Int], _ begin: Int, _ end: Int) {
        var b = begin
        var e = end
        while b < e {
            swap(&a[b], &a[e])
            b = b + 1
            e = e - 1
        }
    }
    
    // ===============================================
    
    func deletedNumberToMakeAnagrams(_ a: String, _ b: String) -> Int {
        var frequencyCharacterDictA = [String: Int]()
        for c in a.characters {
            if frequencyCharacterDictA["\(c)"] == nil {
                frequencyCharacterDictA["\(c)"] = 1
                
            } else {
                frequencyCharacterDictA["\(c)"] = frequencyCharacterDictA["\(c)"]! + 1
            }
        }
        
        var frequencyCharacterDictB = [String: Int]()
        for c in b.characters {
            if frequencyCharacterDictB["\(c)"] == nil {
                frequencyCharacterDictB["\(c)"] = 1
                
            } else {
                frequencyCharacterDictB["\(c)"] = frequencyCharacterDictB["\(c)"]! + 1
            }
        }
        
        var result = 0
        for (key, value) in frequencyCharacterDictA {
            if let temp = frequencyCharacterDictB[key] {
                result = result + abs(value - temp)
                frequencyCharacterDictB[key] = 0
            } else {
                result = result + value
            }
        }
        for (_, value) in frequencyCharacterDictB {
            if value > 0 {
                result = result + value
            }
        }
        
        return result
    }
    
    // ===============================================
    
    func canRansomNote(_ a: String, _ b: String) -> Bool {
        var freqCharactersA = [String: Int]()
        for w in a.components(separatedBy: " ") {
            if freqCharactersA["\(w)"] == nil {
                freqCharactersA["\(w)"] = 1
                
            } else {
                freqCharactersA["\(w)"] = freqCharactersA["\(w)"]! + 1
            }
        }
        
        var freqCharactersB = [String: Int]()
        for w in b.components(separatedBy: " ") {
            if freqCharactersB["\(w)"] == nil {
                freqCharactersB["\(w)"] = 1
                
            } else {
                freqCharactersB["\(w)"] = freqCharactersB["\(w)"]! + 1
            }
        }
        for (key, value) in freqCharactersB {
            if let temp = freqCharactersA[key] {
                if temp < value {
                    return false
                }
            } else {
                return false
            }
        }
        
        return true
    }
    
    // ===============================================
    
//    let number = Int(readLine()!)!
//    for _ in 0..<number {
//    let string = readLine()!
//    print(isBalancedBrackets(string) ? "YES" : "NO")
    
    func isBalancedBrackets(_ a: String) -> Bool {
        if a.characters.count % 2 != 0 {
            return false
        }
        var stack = [String]()
        for c in a.characters {
            if c == "(" {
                stack.append(")")
                
            } else if c == "{" {
                stack.append("}")
                
            } else if c == "[" {
                stack.append("]")
                
            } else {
                if stack.isEmpty || "\(c)" != stack.last {
                    return false
                }
                stack.removeLast()
            }
        }
        
        return stack.isEmpty
    }
    
    // ===============================================
    
    func queueCommand(_ commandCode: Int, _ value: Int? = nil) {
        switch commandCode {
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
    }
}
