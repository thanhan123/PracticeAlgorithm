//
//  ManacherAlgorithm.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 8/27/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

/*
 * Linear time Manacher's algorithm to find longest palindromic substring.
 * There are 4 cases to handle
 * Case 1 : Right side palindrome is totally contained under current palindrome. In this case do not consider this as center.
 * Case 2 : Current palindrome is proper suffix of input. Terminate the loop in this case. No better palindrom will be found on right.
 * Case 3 : Right side palindrome is proper suffix and its corresponding left side palindrome is proper prefix of current palindrome. Make largest such point as
 * next center.
 * Case 4 : Right side palindrome is proper suffix but its left corresponding palindrome is be beyond current palindrome. Do not consider this
 * as center because it will not extend at all.
 *
 * To handle odd size palindromes replace input string with one containing $ between every input character and in start and end.
 */

struct ManacherAlgorithm {
    func longestPalindromicSubstring(string: String) -> String {
        var palindromicNumbers: [Int] = []
        var oddString = "$"
        if string.characters.count % 2 == 0 {
            palindromicNumbers = buildPalindromicStringNumber(string)
           
        } else {
            for character in string.characters {
                oddString = oddString.appending("\(character)$")
            }
            palindromicNumbers = buildPalindromicStringNumber(oddString)
        }
        
        var (position, value) = (0, 0)
        for i in 0..<palindromicNumbers.count {
            let number = palindromicNumbers[i]
            if value < number {
                position = i
                value = number
            }
        }
                
        var result = ""
        if string.characters.count % 2 == 0 {
            let start = string.index(string.startIndex, offsetBy: position - value / 2)
            let end = string.index(string.startIndex, offsetBy: position + value / 2 + 1)
            let range = start..<end
            result = string.substring(with: range)
            
        } else {
            let start = oddString.index(oddString.startIndex, offsetBy: position - value / 2)
            let end = oddString.index(oddString.startIndex, offsetBy: position + value / 2 + 1)
            let range = start..<end
            result = oddString.substring(with: range)
            result = result.replacingOccurrences(of: "$", with: "")
        }
        
        return result
    }
    
    func buildPalindromicStringNumber(_ string: String) -> [Int] {
        var result = [Int](repeating: 1, count: string.characters.count)
        var currCenter: (position: Int, value: Int) = (0, 1)
        for i in 1..<string.characters.count {
            if i > currCenter.position + currCenter.value / 2{
                let newCenter = palindromicSubString(of: string, position: i, firstRange: 1)
                currCenter = newCenter
                result[i] = currCenter.value
                
            } else {
                let palindromeIndexOfI = currCenter.position - (i - currCenter.position)
                if palindromeIndexOfI - result[palindromeIndexOfI] / 2 == currCenter.position - currCenter.value / 2 &&
                    result[palindromeIndexOfI] == currCenter.value / 2 { // case 3: this index "i" is new center
                    let newCenter = palindromicSubString(of: string, position: i, firstRange: result[palindromeIndexOfI] / 2)
                    currCenter = newCenter
                    result[i] = currCenter.value
                    
                } else if palindromeIndexOfI - result[palindromeIndexOfI] / 2  < currCenter.position - currCenter.value / 2 { // case 4
                    let palindromeNumberForCurrentIndex = palindromicSubString(of: string, position: i, firstRange: 1)
                    result[i] = palindromeNumberForCurrentIndex.value
                    
                } else {
                    result[i] = result[palindromeIndexOfI]
                }
            }
            
            if currCenter.position + currCenter.value / 2 >= string.characters.count - 1 { // case 2
                break
            }
        }
        
        return result
    }
    
    func palindromicSubString(of string: String, position: Int, firstRange: Int) -> (position: Int, value: Int) {
        var left = position - firstRange, right = position + firstRange
        while left >= 0 && right < string.characters.count {
            if string[left] == string[right] {
                left = left - 1
                right = right + 1
                
            } else {
                break
            }
        }
        
        left = left + 1
        right = right - 1
        
        return (position, right - left + 1)
    }
    
}
