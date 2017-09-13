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
        var occuranceArray = [(count: Int, index: Int)](repeating: (count: 0, index: 0), count: a.count + 1)
        for i in 0..<a.count {
            let number = a[i]
            if occuranceArray[number].count == 2 {
                continue
            }
            occuranceArray[number] = (occuranceArray[number].count + 1, occuranceArray[number].count == 0 ? occuranceArray[number].index : i)
        }
        var firstDuplicate: (value: Int, index: Int) = (-1, -1)
        for i in 0..<occuranceArray.count {
            let (count, index) = occuranceArray[i]
            if count == 2 && (firstDuplicate.index == -1 || firstDuplicate.index > index)  {
                firstDuplicate = (i, index)
            }
        }
        
        return firstDuplicate.value
    }
}
