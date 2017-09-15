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
    
    func rotateImage(a: inout [[Int]]) -> [[Int]] {
        if a.count <= 1 {
            return a
        }
        for n in 0...a.count - 2 {
            for m in n + 1...a.count - 1 {
                swap(&a[n][m], &a[m][n])
            }
        }
        for n in 0..<a.count {
            for m in 0..<a.count / 2 {
                if m != a.count - 1 - m {
                    swap(&a[n][m], &a[n][a.count - 1 - m])
                }
            }
        }
        
        return a
    }
    
    func sudoku2(grid: [[Character]]) -> Bool {
        for r in 0..<grid.count{
            var tempArray = [Int](repeating: 0, count: grid.count + 1)
            var tempArray2 = [Int](repeating: 0, count: grid.count + 1)
            for c in 0..<grid.count {
                if let number = Int("\(grid[r][c])") {
                    if tempArray[number] == 1 {
                        return false
                    }
                    tempArray[number] = tempArray[number] + 1
                }
                
                if let number = Int("\(grid[c][r])") {
                    if tempArray2[number] == 1 {
                        return false
                    }
                    tempArray2[number] = tempArray2[number] + 1
                }
            }
        }
        
        return true
    }
}
