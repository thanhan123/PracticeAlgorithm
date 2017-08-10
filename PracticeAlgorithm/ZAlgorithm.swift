//
//  ZAlgorithm.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 8/10/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class ZAlgorithm {
    
    func searchPattern(pat: String, text: String) -> [Int] {
        var result = [Int]()
        let m = pat.characters.count
        let concatedString = "\(pat)$\(text)"
        
        let ZArray = BuildZArray(concatedString: concatedString)
        
        for i in 0..<concatedString.characters.count{
            if ZArray[i] == m {
                result.append(i - m - 1)
            }
        }
        
        return result
    }
    
    func BuildZArray(concatedString: String) -> [Int] {
        var result = [0], L = 0, R = 0, k = 0
        let n = concatedString.characters.count
        
        for i in 1..<n {
            if i > R {
                L = i
                R = i
                while i < n && concatedString[concatedString.index(concatedString.startIndex, offsetBy: R-L)] == concatedString[concatedString.index(concatedString.startIndex, offsetBy: R)] {
                    R=R+1
                }
                result.append(R-L)
                R=R-1
            } else {
                k = i - L
                if result[k] + i < R + 1 {
                    result.append(result[k])
                } else {
                    L = i
                    while R < n && concatedString[concatedString.index(concatedString.startIndex, offsetBy: R-L)] == concatedString[concatedString.index(concatedString.startIndex, offsetBy: R)] {
                        R=R+1
                    }
                    result.append(R-L)
                    R=R-1
                }
            }
        }
        
        return result
    }
}
