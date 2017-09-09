//
//  FindSmallestPositiveIntNotInArray.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 9/9/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class FindSmallestPositiveIntNotInArray {
    
    func findSmallestPositiveIntNotInArray(in array: inout [Int]) -> Int{
        let pivot = shiftNegativeElement(in: &array)
        
        var positiveArray: [Int] = []
        for i in pivot..<array.count {
            positiveArray.append(array[i])
        }
        
        return findSmallestMissingElement(in: &positiveArray)
    }
    
    internal func shiftNegativeElement(in array: inout [Int]) -> Int{
        var changedPosition = -1
        
        for i in 0..<array.count {
            if array[i] <= 0 {
                changedPosition = changedPosition + 1
                swap(&array[changedPosition], &array[i])
            }
        }
        
        return changedPosition + 1
    }
    
    internal func findSmallestMissingElement(in array: inout [Int]) -> Int {
        
        // Mark array[i] as visited by making array[array[i] - 1] negative. Note that
        // 1 is subtracted because index start from 0 and positive numbers start from 1
        for i in 0..<array.count {
            if abs(array[i]) - 1 < array.count && array[abs(array[i]) - 1] > 0 {
                array[abs(array[i]) - 1] = -array[abs(array[i]) - 1]
            }
        }
        
        for i in 0..<array.count {
            if array[i] > 0 {
                return i + 1
            }
        }
        
        return array.count + 1
    }
    
}
