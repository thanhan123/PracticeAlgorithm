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
    var countingSort: CountingSort!
    var findDuplicateElementInArray: FindDuplicateElementInArray!
    var smallestPositiveNotInArray: FindSmallestPositiveIntNotInArray!
    var codilityTest: CodilityTest!
    var manacher: ManacherAlgorithm!
    var codeFight: CodeFightsTest!
    var hackerRank: HackerRank!
    
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
        countingSort = CountingSort()
        findDuplicateElementInArray = FindDuplicateElementInArray()
        smallestPositiveNotInArray = FindSmallestPositiveIntNotInArray()
        codilityTest = CodilityTest()
        manacher = ManacherAlgorithm()
        codeFight = CodeFightsTest()
        hackerRank = HackerRank()
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
        let k = 4
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
    
    func testCountingSort() {
        let sortedArray = countingSort.countingSort(array: [1, 4, 1, 2, 7, 5, 2, 0 , 8, 9], maxVal: 9, minVal: 0)
        print("***** \(sortedArray)")
    }
    
    func testFindDuplicateElementInArray() {
        var array = [1, 2, 3, 1, 3, 6, 6]
        let duplicateEleArray = findDuplicateElementInArray.findDuplicateElement(in: &array)
        print("***** duplicateEleArray: \(duplicateEleArray)")
    }
    
    func testFindSmallestPositiveIntNotInArray() {
        var array = [-1, -3] //[2, 3, -7, 6, 8, 1, -10, 15]
        print("***** smallestEleNotInArray: \(smallestPositiveNotInArray.findSmallestPositiveIntNotInArray(in: &array))")
    }
    
    func testCodility() {
         print("***** LongestSlice: \(codilityTest.getLongestSlice(array: [5, 4, 4, 3, 12]))")
         print("***** MaximumAdjacentDistance: \(codilityTest.getMaximumAdjacentDistance(array: [0, 3, 3, 7, 5, 3, 1, 11, 3]))")
    }
    
    func testManacherAlgorithm() {
        let result = manacher.longestPalindromicSubstring(string: "abaxabaxabybaxabyb")
        XCTAssert(result == "baxabybaxab")
        let result2 = manacher.longestPalindromicSubstring(string: "baab")
        XCTAssert(result2 == "baab")
        let result3 = manacher.longestPalindromicSubstring(string: "abaab")
        XCTAssert(result3 == "baab")
    }
    
    func testCountNonDivisor() {
        let result = codilityTest.countNonDivisor([3, 1, 2, 3, 6])
        print("***** CountNonDivisor: \(result)")
    }
    
    func testSieveEratosthenes() {
        let result = codilityTest.solutionSieveEratosthenes(99)
        print("***** NUmber of prime number <= 50: \(result)")
    }
    
    func testMinAbsSumOfTwo() {
        var input = [-8, 4, 5, -10, 3]
        let result = codilityTest.minAbsSumOfTwo(&input)
        print("***** MinAbsSumOfTwo: \(result)")
        XCTAssert(result == 3)
        
        var input2 = [1, 4, -3]
        let result2 = codilityTest.minAbsSumOfTwo(&input2)
        print("***** MinAbsSumOfTwo: \(result2)")
        XCTAssert(result2 == 1)
        
        var input3 = [-10, 4, 10]
        let result3 = codilityTest.minAbsSumOfTwo(&input3)
        print("***** MinAbsSumOfTwo: \(result3)")
        XCTAssert(result3 == 0)
    }
    
    func testNailingPlanks() {
        let A = [1, 4, 5, 8], B = [4, 5, 9, 10], C = [4, 6, 7, 10, 2]
        let result = codilityTest.solutionNailingPlanks(A, B, C)
        print("***** NailingPlanks: \(result)")
        XCTAssert(result == 4)
    }
    
    func testFirstDuplicate() {
        let A = [2, 3, 3, 1, 5, 2]
        let result = codeFight.firstDuplicate(A)
        print("***** FirstDuplicate: \(result)")
        XCTAssert(result == 3)
        
        let B = [1, 1, 2, 2, 1]
        let result2 = codeFight.firstDuplicate(B)
        print("***** FirstDuplicate: \(result2)")
        XCTAssert(result2 == 1)
    }
    
    func testAddTwoHugeNumbersSolution() {
        let a = ListNode<Int>(123)
        a.next = ListNode<Int>(4)
        a.next?.next = ListNode<Int>(5)
        
        let b = ListNode<Int>(100)
        b.next = ListNode<Int>(100)
        b.next?.next = ListNode<Int>(100)
        
        let result = codeFight.addTwoHugeNumbers(a: a, b: b)
        codeFight.printList(l: result)
    }
    
    func testReverseNodesInKGroups() {
        let a = ListNode<Int>(1)
        a.next = ListNode<Int>(2)
        a.next?.next = ListNode<Int>(3)
        a.next?.next?.next = ListNode<Int>(4)
//        a.next?.next?.next?.next = ListNode<Int>(5)
        
        let result = codeFight.reverseNodesInKGroups(l: a, k: 2)
        codeFight.printList(l: result)
    }
    
    func testRearrangeLastN() {
        let a = ListNode<Int>(1)
        a.next = ListNode<Int>(2)
        a.next?.next = ListNode<Int>(3)
        a.next?.next?.next = ListNode<Int>(4)
        a.next?.next?.next?.next = ListNode<Int>(5)
        
        let result = codeFight.rearrangeLastN(l: a, n: 2)
        codeFight.printList(l: result)
    }
    
    func testGroupingDishes() {
        let dishes = [["dSaLKJGbxlxcBBv kMNOmzdojCluYeCb","zjxwKcRmpQTPSPRUKLfAhkIXxfzniZjsDfaKOJOcVDaxAnCF"],
                      ["R GBgXIv","fPhNHIdOTeKPnqaIPAYXScGrDyGWwlqktYtyOzondayKp","xJ hfufIWL","YduFVZrZEeqVmvACdSTdQd uMswBcadvet","WHYOLUzwSHKUuCNry"],
                      ["kvHxWutzASOCBHV","wpzmQKLROsw ","sxgFkhrwFKB","reRqP TFlpmiQa GoZTuErWVB","LA","BGQgMdEGXutmmE InKtapSHbwZlPHrvPwbSmRWclamnTW","QgBClPTxsIpAl","SWbXtEIFeVqoUgtSfXKcVmnwDrijLYsPeXfUauFVbBkbEmGDa"],
                      ["Hgpu","fvORUPNvHmBtpKpbTRbmdXzicYOZotLmfoLmQIqBInPnbCFN","WHYOLUzwSHKUuCNry"],
                      ["gZxWYomyYO","fvORUPNvHmBtpKpbTRbmdXzicYOZotLmfoLmQIqBInPnbCFN","YduFVZrZEeqVmvACdSTdQd uMswBcadvet","XxRAIFwrGmaarKfz","yJffViKwbqCATxHcQFDLgMX","poEnqRtrANh","QgBClPTxsIpAl","dyqdvHDdflvzxVAGRyxWPMBtIDJhv paNyJbWab"],
                      ["rMSYkYkFKlcdBTrUpCTdFgEIdgdTOcEucJdPqiLUWUZNjcoL","YduFVZrZEeqVmvACdSTdQd uMswBcadvet","QgBClPTxsIpAl","fPhNHIdOTeKPnqaIPAYXScGrDyGWwlqktYtyOzondayKp","udzzsbLVValZOWpRLhUKumkROw","dyqdvHDdflvzxVAGRyxWPMBtIDJhv paNyJbWab","WHYOLUzwSHKUuCNry","LA","fvORUPNvHmBtpKpbTRbmdXzicYOZotLmfoLmQIqBInPnbCFN"],
                      ["GrWh ROg zHXhYguurdcGjNAv","dyqdvHDdflvzxVAGRyxWPMBtIDJhv paNyJbWab","YduFVZrZEeqVmvACdSTdQd uMswBcadvet","AQglifKDgZIivthzfoWRklaKs","UcIBqQckdEJgLeWMlaRPlqfkhVRXjtZHAYDVRhPsFqPOuEVN","LA","MWhqbkFrSTnOuWKexjPewdd AOISBnSCilJ","QgBClPTxsIpAl"],
                      ["dLuvsltPzUjfXkynBCMgxBUTXhVCd","udzzsbLVValZOWpRLhUKumkROw","BGQgMdEGXutmmE InKtapSHbwZlPHrvPwbSmRWclamnTW","BjRRCVKznaySRzyAuNxAbkSYTmcUGlvOND","wpzmQKLROsw ","qLKOIfeBowxWwxPJWrWjtVXMkG NXOLxYxvCKoAagSHYRxVgK","WdfleYASWwVMQKoBINhwpjDbVBEaOOogkKMZ","AQglifKDgZIivthzfoWRklaKs","qRUsCllaFzNWuXIMvbOsNtTTAlbR"],
                      ["jOubIROdYWOKxwbZTLDueBiln","fTUBneoUSWxFERZjwPMrAQq","NPuomEOeOXBiozrNZXlXcKKB","ibogPWJoEbermlJfuizYaE","zpNFvjef mpEbEqy rdudPTGpzo n FwxTA"],
                      ["BiNYUHMFrRoSICZ","ufYAxvBidQjinsDCurHyjlzRHrOQ MbIVKGLwAq","nvHaaRJdHgRIgXXQteAchX MKldBbM","TdBMoUrYiEcJPlERejkAQdxYMTatLYXX","qLKOIfeBowxWwxPJWrWjtVXMkG NXOLxYxvCKoAagSHYRxVgK"]]
        
        let result = codeFight.groupingDishes(dishes: dishes)
        print(result)
    }
    
    func testLeftRotationArray() {
        var A = [1, 2, 3, 4, 5]
        let result = hackerRank.leftRotationArray(&A, 2)
        print(result)
    }
    
    func testDeletedNumberToMakeAnagrams() {
        let a = "fcrxzwscanmligyxyvym", b = "jxwtrhvujlmrpdoqbisbwhmgpmeoke"
        let result = hackerRank.deletedNumberToMakeAnagrams(a, b)
        print(result)
    }
    
    func testCanRansomNote() {
        let a = "give me one grand today night", b = "give one grand today"
        let result = hackerRank.canRansomNote(a, b)
        print(result)
    }
    
    func testIsBalancedBrackets() {
        let a = "{[()]}", b = "{[(])}", c = "{{[[(())]]}}", d = "{}{()}{{}}", e = "(]]){)][((}((){[(((]((})[((}][]{[]}([][]])({][){}}[{{]}])}()(}{)]}]])(}{[][]){([)))[{[[)))(}][]{]}[{([(}]([{{{))}})}[)[](}({((}{)(](}[}[[())()]",
        f = "{(()()})([)(}{(])[{([]){}{{{]{]{{}[({]{[(()){}[)}(([[([{}}){]](}[{}}(){}[[)[}}{}[]{(){][]](}]})[[))))][}(}()){()}([}([})[[}}({{[)}][[]])[[}])]][](([}()[)}])][}}}(()(())({{[]][))}{[[[]]{{[{]}{}}))"
        
        let result = hackerRank.isBalancedBrackets(a)
        XCTAssert(result == true)
        
        let result2 = hackerRank.isBalancedBrackets(b)
        XCTAssert(result2 == false)
        
        let result3 = hackerRank.isBalancedBrackets(c)
        XCTAssert(result3 == true)
        
        let result4 = hackerRank.isBalancedBrackets(d)
        XCTAssert(result4 == true)
        
        let result5 = hackerRank.isBalancedBrackets(e)
        XCTAssert(result5 == false)
        
        let result6 = hackerRank.isBalancedBrackets(f)
        XCTAssert(result6 == false)
    }
    
    func testHasPathWithGivenSum() {
        let t = Tree<Int>(8)
        t.right = Tree<Int>(3)
        
        XCTAssert(codeFight.hasPathWithGivenSum(t: t, s: 8) == false)
        
        let t2 = Tree<Int>(4)
        t2.left = Tree<Int>(1)
        t2.left?.left = Tree<Int>(-2)
        t2.left?.left?.right = Tree<Int>(3)
        
        t2.right = Tree<Int>(3)
        t2.right?.left = Tree<Int>(1)
        t2.right?.right = Tree<Int>(2)
        t2.right?.right?.left = Tree<Int>(-2)
        t2.right?.right?.right = Tree<Int>(-3)
        
        XCTAssert(codeFight.hasPathWithGivenSum(t: t2, s: 7) == true)
    }
    
    func testIsTreeSymmetric() {
        let t = Tree<Int>(8)
        t.right = Tree<Int>(3)
        
        XCTAssert(codeFight.isTreeSymmetric(t: t) == false)
        
        let t2 = Tree<Int>(1)
        t2.left = Tree<Int>(2)
        t2.left?.left = Tree<Int>(3)
        t2.left?.right = Tree<Int>(4)
        
        t2.right = Tree<Int>(2)
        t2.right?.left = Tree<Int>(4)
        t2.right?.right = Tree<Int>(3)
        
        XCTAssert(codeFight.isTreeSymmetric(t: t2) == true)
        
        let t3 = Tree<Int>(1)
        t3.left = Tree<Int>(2)
        t3.left?.left = Tree<Int>(3)
        
        t3.right = Tree<Int>(2)
        t3.right?.left = Tree<Int>(3)
        
        XCTAssert(codeFight.isTreeSymmetric(t: t3) == false)
    }
    
    func testFindProfession() {
        XCTAssert(codeFight.findProfession(level: 4, pos: 5) == "Doctor")
    }
}
