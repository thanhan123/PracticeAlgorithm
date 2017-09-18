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
}
