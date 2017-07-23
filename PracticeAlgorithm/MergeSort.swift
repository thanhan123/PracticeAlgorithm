//
//  MergeSort.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 7/23/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class MergeSort {
    func mergeSort(_ array: inout [Int]) -> [Int] {
        if array.count > 1 {
            
            var subArray1: [Int] = []
            var subArray2: [Int] = []
            
            for i in 0...array.count - 1 {
                if i < array.count / 2 {
                    subArray1.append(array[i])
                } else {
                    subArray2.append(array[i])
                }
            }
            
            var sortedArray = mergeSort(&subArray1)
            var sortedArray2 = mergeSort(&subArray2)
            
            return mergeTwoSortedArrays(&sortedArray, &sortedArray2)
        } else {
            return array
        }
    }
    
    func mergeTwoSortedArrays(_ array: inout [Int], _ array2: inout [Int]) -> [Int] {
        var resultArray: [Int] = []
        
        var compareEle = array.first!
        var compareEle2 = array2.first!
        
        while true {
            if compareEle < compareEle2 {
                resultArray.append(compareEle)
                array.removeFirst()
            } else {
                resultArray.append(compareEle2)
                array2.removeFirst()
            }
            
            if array.count == 0 || array2.count == 0 {
                break
            }
            
            compareEle = array.first!
            compareEle2 = array2.first!
        }
        
        for ele in array {
            resultArray.append(ele)
        }
        
        for ele in array2 {
            resultArray.append(ele)
        }
        
        return resultArray
    }
}
