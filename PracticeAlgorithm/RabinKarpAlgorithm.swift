//
//  RabinKarpAlgorithm.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 8/7/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class RabinKarpAlgorithm {
    
    func searchPattern(_ pattern: String, inText text: String, withPrime q:Int) -> [Int] {
        var result = [Int]()
        
        let m = pattern.characters.count, n = text.characters.count, d = 256
        var h = 1, t = 0, p = 0
        
        // The value of h would be "pow(d, M-1)%q"
        for _ in 0..<m - 1{
            h = (h * d) % q
        }
        
        for i in 0...m - 1{
            let pi = pattern[pattern.index(pattern.startIndex, offsetBy: i)]
            let ti = text[text.index(text.startIndex, offsetBy: i)]
            p = (d*p + Int(pi.asciiValue!)) % q
            t = (d*t + Int(ti.asciiValue!)) % q
        }
        
        for i in 0...n - m {
            if t == p {
                var match = true
                
                for j in 0..<m {
                    if pattern[pattern.index(pattern.startIndex, offsetBy: j)] != text[text.index(text.startIndex, offsetBy: i+j)] {
                        match = false
                        break
                    }
                }
                
                if match == true {
                    result.append(i)
                }
            }
            
            if i < n - m {
                let ti = text[text.index(text.startIndex, offsetBy: i)]
                let tim = text[text.index(text.startIndex, offsetBy: i+m)]
                t = (d*(t - Int(ti.asciiValue!) * h) + Int(tim.asciiValue!)) % q
                if t < 0 {
                    t = t + q
                }
            }
        }
        
        return result
    }
}

extension String {
    var asciiArray: [UInt32] {
        return unicodeScalars.filter{$0.isASCII}.map{$0.value}
    }
}

extension Character {
    var asciiValue: UInt32? {
        return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }
}
