//
//  MergeKSortedArrays.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 7/21/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class MergeSortedArrays {
    
    func mergeSortedArrays(_ arrays: inout [[Int]]) -> [Int]{
        var resultArray: [Int] = []
        
        var considerArray: [(Int, Int)] = []
        
        for i in 0...arrays.count - 1 {
            considerArray.append((arrays[i].first!, i))
            arrays[i].removeFirst()
        }
        
        while true {
            if considerArray.count == 1 {
                resultArray.append(considerArray.first!.0)
                for value in arrays[considerArray.first!.1] {
                    resultArray.append(value)
                }
                break
            }
            
            for i in (0...considerArray.count / 2 - 1).reversed() {
                heapifyMin(&considerArray, considerArray.count, i)
            }
            
            let minValue = considerArray.first!.0
            let minValueIndex = considerArray.first!.1
            
            resultArray.append(minValue)
            
            if arrays[minValueIndex].count >= 1 {
                considerArray[0] = (arrays[minValueIndex].first!, minValueIndex)
                arrays[minValueIndex].removeFirst()
            } else {
                considerArray.removeFirst()
            }
            
            if considerArray.count == 0 {
                break
            }
        }
        
        return resultArray
    }
    
    func heapifyMin(_ array: inout [(Int, Int)], _ arrayCount: Int, _ topIndex: Int) {
        var maxIndex = topIndex
        
        let left = 2*topIndex+1
        let right = 2*topIndex+2
        
        if left < arrayCount && array[left].0 < array[maxIndex].0 {
            maxIndex = left
        }
        
        if right < arrayCount && array[right].0 < array[maxIndex].0 {
            maxIndex = right
        }
        
        if maxIndex != topIndex {
            swap(&array[topIndex], &array[maxIndex])
            heapifyMin(&array, arrayCount, maxIndex)
        }
    }
    
}
