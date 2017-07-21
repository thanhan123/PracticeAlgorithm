//
//  PracticeAlgorithmTests.swift
//  PracticeAlgorithmTests
//
//  Created by Dinh Thanh An on 7/21/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import XCTest
@testable import PracticeAlgorithm
class PracticeAlgorithmTests: XCTestCase {
    
    var mergeSortedArraysAlgorithm: MergeSortedArrays!
    var quickSortAlgorithm: QuickSort!
    var heapSortAlgorithm: HeapSort!
    
    override func setUp() {
        super.setUp()
        quickSortAlgorithm = QuickSort()
        heapSortAlgorithm = HeapSort()
        mergeSortedArraysAlgorithm = MergeSortedArrays()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceQuickSort() {
        var myArray: [Int] = [];
                
        for _ in 1...10000{
            let randomNum:UInt32 = arc4random_uniform(10000)
            myArray.append(Int(randomNum))
        }
        
        self.measure {
            self.quickSortAlgorithm.quickSort(&myArray, 0, myArray.count - 1)
        }
    }
    
    func testPerformanceMergeSortedArray() {
        var myArray = [[2, 6, 12, 34],
                       [1, 9, 20, 1000],
                       [23, 34, 90, 2000]];
        
//        self.measure {
            print(self.mergeSortedArraysAlgorithm.mergeSortedArrays(&myArray)) 
//        }
    }
    
    func testPerformanceHeapSort() {
        var myArray: [Int] = [];
        
        for _ in 1...100000{
            let randomNum:UInt32 = arc4random_uniform(10000)
            myArray.append(Int(randomNum))
        }
        
        self.measure {
            self.heapSortAlgorithm.heapSort(&myArray)
        }
    }
    
}
