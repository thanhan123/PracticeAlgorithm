//
//  CodilityTest.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 9/10/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class CodilityTest {
    
    func getMaximumAdjacentDistance(array: [Int]) -> Int {
        var result = 0
        var array2: [(Int, Int)] = [], tmp: [(Int, Int)] = []
        
        for i in 0..<array.count {
            array2.append((array[i], i))
        }
        
        array2.sort { a, b -> Bool in
            a.0 < b.0
        }
        
        for tuple in array2 {
            if tmp.count < 1 {
                tmp.append(tuple)
                
            } else {
                let last = tmp[tmp.count - 1]
                if last.0 != tuple.0 {
                    let adjacentDistance = abs(last.1 - tuple.1)
                    result = max(result, adjacentDistance)
                    if tmp.count == 1 {
                        tmp.append(tuple)
                        
                    } else {
                        tmp = [last, tuple]
                    }
                }
            }
        }
        
        return result
    }
    
    func getLongestSlice(array: [Int]) -> Int{
        
        var count = 0,
        max = 0,
        temp: [(Int, Int)] = [];
        
        for a in array {
            var last = (-1, -1)
            
            if temp.count > 0 {
                last = temp[temp.count - 1]
            }
            
            if (temp.count < 2 || temp[0].0 == a || temp[1].0 == a) {
                count = count + 1
                
            } else {
                count = last.1 + 1;
            }
            
            if (temp.count > 0 && last.0 == a) {
                last.1 = last.1 + 1;
                temp[temp.count - 1] = last
                
            } else {
                temp.append((a, 1))
                if temp.count > 1 {
                    let nextLastItem = temp[temp.count - 2]
                    let lastItem = temp[temp.count - 1]
                    temp = [nextLastItem, lastItem]
                }
            }
            
            if (count > max) {
                max = count;
            }
        }
        
        return max;
    }
    
    func countNonDivisor(_ A: [Int]) -> [Int] {
        var countArray = [Int](repeating: 0, count: A.count * 2 + 1)
        for a in A {
            countArray[a] = countArray[a] + 1
        }
        
        var divisors = [Int](repeating: 0, count: A.count)
        
        for i in 0..<A.count {
            var numberOfDivisor = 0
            let a = A[i], target = Int(sqrt(Double(a)))
            for divisor in 1...target{
                if a % divisor == 0 {
                    numberOfDivisor = numberOfDivisor + countArray[divisor]
                    if a / divisor != divisor {
                        numberOfDivisor = numberOfDivisor + countArray[a / divisor]
                    }
                }
            }
            divisors[i] = A.count - numberOfDivisor
        }
        
        return divisors
    }
    
    func solutionSieveEratosthenes(_ N: Int) -> [Int]{
        var primeNumberIndex = [Bool](repeating: true, count: N + 1)
        primeNumberIndex[0] = false
        primeNumberIndex[1] = false
        
        var p = 2
        while p*p <= N {
            if primeNumberIndex[p] == true {
                var i = p*p
                while i <= N {
                    primeNumberIndex[i] = false
                    i = i + p
                }
            }
            
            p = p + 1
        }
        
        var result = [Int]()
        for i in 2..<primeNumberIndex.count {
            if primeNumberIndex[i] == true {
                result.append(i)
            }
        }
        
        return result
    }
    
    func minAbsSumOfTwo(_ A: inout [Int]) -> Int {
        A.sort { a, b -> Bool in
            abs(a) < abs(b) // sort array by abs value, abs small value is at back -> abs large value is at front
        }
        var minAbs = abs(2*A[0]) // this is smallest value among sums of value with same index
        for i in 1..<A.count {
            minAbs = min(minAbs, abs(A[i] + A[i-1])) // check wether there is any sum of diff index is samller than min result
        }
        
        return minAbs
    }
    
    func solutionNailingPlanks(_ A: [Int], _ B: [Int], _ C:[Int]) -> Int {
        var begin = 0, end = C.count - 1, result = -1
        while begin <= end {
            let mid = (begin + end) / 2
            if check(A, B, C, mid + 1) == true {
                end = mid - 1
                result = mid + 1
            } else {
                begin = mid + 1
            }
        }
        
        return result
    }
    
    internal func check(_ A: [Int], _ B: [Int], _ C:[Int], _ num: Int) -> Bool {
        var pNails = [Int](repeating: 0, count: 2*C.count + 1)
        for i in 0..<num {
            pNails[C[i]] = pNails[C[i]] + 1
        }
        for i in 1..<pNails.count {
            pNails[i] = pNails[i] + pNails[i - 1]
        }
        for i in 0..<A.count {
            if pNails[B[i]] <= pNails[A[i] - 1] {
                return false
            }
        }
        return true
    }
}
