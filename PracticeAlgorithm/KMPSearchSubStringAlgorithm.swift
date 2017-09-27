//
//  KMPSearchSubStringAlgorithm.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 8/7/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class KMPSearchSubStringAlgorithm {
    
    func searchPattern(_ pattern: String, inText text: String) -> [Int] {
        var result: [Int] = []
        
        let lps = buildLPSArray(pattern)
        
        var j = 0, i = 0
        
        while i < text.characters.count {
            if text[text.index(text.startIndex, offsetBy: i)] == pattern[pattern.index(pattern.startIndex, offsetBy: j)]  {
                j = j + 1
                i = i + 1
            }
            
            if j == pattern.characters.count{
                result.append(i - j)
                j = lps[j - 1]
            } else if i < text.characters.count && text[text.index(text.startIndex, offsetBy: i)] != pattern[pattern.index(pattern.startIndex, offsetBy: j)] {
                if j != 0 {
                    j = lps[j - 1]
                } else {
                    i = i + 1
                }
            }
        } 
        
        return result
    }
    
    internal func buildLPSArray(_ pattern: String) -> [Int] {
        var lps = [0]
        
        var j = 0, i = 1
        
        while i < pattern.characters.count {
            
            if pattern[pattern.index(pattern.startIndex, offsetBy: i)] == pattern[pattern.index(pattern.startIndex, offsetBy: j)]  {
                lps.append(j+1)
                j = j + 1
                i = i + 1
            } else {
                if j == 0 {
                    lps.append(0)
                    i = i + 1
                } else {
                    j = lps[j - 1]
                }
            }
        }
        
        return lps
    }
}
