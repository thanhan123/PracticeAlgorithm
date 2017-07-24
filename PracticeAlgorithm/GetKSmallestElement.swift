//
//  GetKSmallestElement.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 7/24/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class GetKSmallestElement {
    let heapSort = HeapSort()
    
    func getKSmallestElement(_ array: inout [Int], _ K: Int) {
        for j in 0...K - 1 {
            for i in (0...array.count / 2 - 1).reversed() {
                heapSort.heapifyMin(&array, array.count - j, i)
            }
            swap(&array[0], &array[array.count - j - 1])
        }
    }
}
