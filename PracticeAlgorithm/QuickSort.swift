//
//  QuickSort.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 7/21/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class QuickSort {
    func quickSort(_ array: inout [Int], _ low: Int, _ high: Int){
        if low < high {
            let pivot = partition(&array, low, high)
            quickSort(&array, low, pivot - 1)
            quickSort(&array, pivot + 1, high)
        }
    }
    
    func partition(_ array: inout [Int], _ start: Int, _ end: Int) -> Int{
        
        let standard = array[end];
        var begin = start - 1
        
        for i in start...end - 1 {
            if array[i] <= standard { // bring element which is <= standard to the head of the array
                begin = begin + 1
                if begin != i {
                    swap(&array[begin], &array[i])
                }
            }
        }
        
        if begin + 1 != end {
            swap(&array[begin + 1], &array[end])
        }
        
        return begin + 1;
    }
}
