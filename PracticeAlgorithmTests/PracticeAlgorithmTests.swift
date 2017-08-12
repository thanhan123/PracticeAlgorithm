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
    var binarySearchAlgorithm: BinarySearch!
    var mergeSortAlgorithm: MergeSort!
    var getKSmallestElement: GetKSmallestElement!
    var kmpAlgorithm: KMPSearchSubStringAlgorithm!
    var rabinKarpAlgorithm: RabinKarpAlgorithm!
    var zAlgorithm: ZAlgorithm!
    var trie: Trie!
    
    override func setUp() {
        super.setUp()
        
        quickSortAlgorithm = QuickSort()
        heapSortAlgorithm = HeapSort()
        mergeSortedArraysAlgorithm = MergeSortedArrays()
        binarySearchAlgorithm = BinarySearch()
        mergeSortAlgorithm = MergeSort()
        getKSmallestElement = GetKSmallestElement()
        kmpAlgorithm = KMPSearchSubStringAlgorithm()
        rabinKarpAlgorithm = RabinKarpAlgorithm()
        zAlgorithm = ZAlgorithm()
        trie = Trie()
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
    
    func testBinarySarch() {
//        var myArray: [Int] = [];
//        
//        for _ in 1...10000{
//            let randomNum:UInt32 = arc4random_uniform(10000)
//            myArray.append(Int(randomNum))
//        }
//        
//        self.quickSortAlgorithm.quickSort(&myArray, 0, myArray.count - 1)
//        
//        print(myArray)
        
        let foundIndex = self.binarySearchAlgorithm.binarySearch([-10, 20, 33, 45, 89, 202, 456], 456)
        
        print("****** found index: \(foundIndex)")
    }
    
    func testMergeSort() {
        var array: [Int] = [38, 27, 45, 43, 3, -5, 9, 82, 10]
        let sortedArray = mergeSortAlgorithm.mergeSort(&array)
        
        print("****** sorted array: \(sortedArray)")
    }
    
    func testFindKSmallestElement() {
        var array: [Int] = [12, 3, 5, 7, 19]
        let k = 2
        getKSmallestElement.getKSmallestElement(&array, k)
        
        print("****** \(k)'th smallest element: \(array[array.count - k])")
    }
    
    func testKMPAlgorithm() {
        let text = "ABABDABACDABABCABAB"
        let pat = "ABABCABAB"
        print("****** \(kmpAlgorithm.searchPattern(pat, inText: text))")
    }
    
    func testRabinKarp() {
        let text = "GEEKS FOR GEEKS"
        let pat = "GEEK"
        print("****** \(rabinKarpAlgorithm.searchPattern(pat, inText: text, withPrime: 101))")
    }
    
    func testZAlgorithm() {
        let text = "GEEKS FOR GEEKS"
        let pat = "GEEK"
        print("****** \(zAlgorithm.searchPattern(pat: pat, text: text))")
    }
    
    func testTrie() {
        trie.insert(word: "abc")
        trie.insert(word: "abcdef")
        trie.insert(word: "opqrs")
        
        XCTAssertTrue(trie.search(word: "abc") == true, "found abc")
        XCTAssertTrue(trie.search(word: "abcdef") == true, "found abcdef")
        XCTAssertTrue(trie.search(word: "some string") == false, "not found some string")
        XCTAssertTrue(trie.search(word: "opqrs") == true, "found opqrs")
        trie.delete(word: "abcdef")
        XCTAssertTrue(trie.search(word: "abcdef") == false, "not found abcdef")
        XCTAssertTrue(trie.search(word: "abc") == true, "found abc")
    }
    
}
