//
//  BinarySearch.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 7/23/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class BinarySearch {
    func binarySearch(_ array: [Int], _ key: Int) -> Int{
        var start = 0
        var end = array.count - 1
        
        while start <= end {
            let mid = start + (end - start)/2
            if array[mid] == key {
                return mid
            } else if array[mid] > key {
                end = mid - 1
            } else {
                start = mid + 1
            }
        }
        
        return -1
    }
}
