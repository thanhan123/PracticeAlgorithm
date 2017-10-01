//
//  InsertionSort.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 9/29/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class InsertionSort {
    func sort<T>(_ a: inout [T], _ isOrderBefore: (T, T) -> Bool) {
        for i in 1..<a.count {
            var j = i, temp = a[j]
            while j > 0 && isOrderBefore(temp, a[j - 1]) {
                a[j] = a[j - 1]
                j-=1
            }
            a[j] = temp
        }
    }
}
