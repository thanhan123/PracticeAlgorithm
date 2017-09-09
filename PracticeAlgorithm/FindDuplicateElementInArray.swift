//
//  FindDuplicateElementInArray.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 9/9/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

//  Given an array of n elements which contains elements from 0 to n-1, with any of these numbers appearing any number of times. Find these repeating numbers in O(n) and using only constant memory space.

class FindDuplicateElementInArray {
    
    func findDuplicateElement(in array: inout [Int]) -> [Int] {
        var result: [Int] = []
        for i in 0..<array.count {
            if array[abs(array[i])] > 0 {
                array[abs(array[i])] = -array[abs(array[i])]
                
            } else {
                let dupEle = abs(array[i])
                result.append(dupEle)
            }
        }
        
        return result
    }
}
