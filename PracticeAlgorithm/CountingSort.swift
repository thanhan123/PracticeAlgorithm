//
//  CountingSort.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 8/27/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

struct CountingSort {
    
    func countingSort(array: [Int], maxVal: Int, minVal: Int) -> [Int]{
        var countArray = [Int]()
        for _ in minVal...maxVal{
            countArray.append(0)
        }
        
        for i in 0..<array.count {
            countArray[array[i]] = countArray[array[i]] + 1
        }
        
        for i in 1..<countArray.count {
            countArray[i] = countArray[i - 1] + countArray[i]
        }
        
        var resultArray = [Int]()
        for _ in 0..<array.count{
            resultArray.append(0)
        }
        
        for i in 0..<array.count {
            resultArray[countArray[array[i]] - 1] = array[i]
            countArray[array[i]] = countArray[array[i]] - 1
        }
        
        return resultArray
    }
}
