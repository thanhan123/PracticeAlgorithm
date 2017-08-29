//
//  HeapSort.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 7/21/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class HeapSort {
    func heapSort(_ array: inout [Int]) {
        for i in (0...array.count / 2 - 1).reversed() {
            heapifyMax(&array, array.count, i)
        }
        
        for i in (0..<array.count).reversed() {
            if i != 0 {
                swap(&array[i], &array[0]) // bring max element to the tail of the array
            }
            heapifyMax(&array, i, 0) // make max-heap with array except last element
        }
    }
    
    func heapifyMax(_ array: inout [Int], _ arrayCount: Int, _ topIndex: Int) {
        var maxIndex = topIndex
        
        let left = 2*topIndex+1
        let right = 2*topIndex+2
        
        if left < arrayCount && array[left] > array[maxIndex] {
            maxIndex = left
        }
        
        if right < arrayCount && array[right] > array[maxIndex] {
            maxIndex = right
        }
        
        if maxIndex != topIndex {
            swap(&array[topIndex], &array[maxIndex])
            heapifyMax(&array, arrayCount, maxIndex)
        }
    }
    
    func heapifyMin(_ array: inout [Int], _ arrayCount: Int, _ topIndex: Int) {
        var maxIndex = topIndex
        
        let left = 2*topIndex+1
        let right = 2*topIndex+2
        
        if left < arrayCount && array[left] < array[maxIndex] {
            maxIndex = left
        }
        
        if right < arrayCount && array[right] < array[maxIndex] {
            maxIndex = right
        }
        
        if maxIndex != topIndex {
            swap(&array[topIndex], &array[maxIndex])
            heapifyMin(&array, arrayCount, maxIndex)
        }
    }
}
