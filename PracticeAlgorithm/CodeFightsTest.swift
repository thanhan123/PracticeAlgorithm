//
//  CodeFightsTest.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 9/13/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

// Definition for singly-linked list:
public class ListNode<T> {
    public var value: T
    public var next: ListNode<T>?
    public init(_ x: T) {
        self.value = x
        self.next = nil
    }
}

class CodeFightsTest {
    func firstDuplicate(_ a: [Int]) -> Int {
        var occuranceArray = [Int](repeating: 0, count: a.count + 1)
        for i in 0..<a.count {
            let number = a[i]
            if occuranceArray[number] == 1 {
                return number
            }
            occuranceArray[number] = occuranceArray[number] + 1
        }
        
        return -1
    }
    
    // ==========================================
    
    func firstNotRepeatingCharacter(s: String) -> Character {
        var uniqueCharacterString = ""
        var repeatedCharacterString = ""
        for c in s.characters {
            if !uniqueCharacterString.contains("\(c)") {
                uniqueCharacterString = uniqueCharacterString.appending("\(c)")
            } else if !repeatedCharacterString.contains("\(c)"){
                repeatedCharacterString = repeatedCharacterString.appending("\(c)")
            }
        }
        
        for c in repeatedCharacterString.characters {
            uniqueCharacterString = uniqueCharacterString.replacingOccurrences(of: "\(c)", with: "")
        }
        
        return uniqueCharacterString.characters.count > 0 ? uniqueCharacterString.characters.first! : "_"
    }
    
    // ==========================================
    
    func isCryptSolution(crypt: [String], solution: [[Character]]) -> Bool {
        var solutionDict = [String: String]()
        
        for s in solution {
            solutionDict["\(s[0])"] = "\(s[1])"
        }
        
        var encryptedArray = [Int]()
        
        for c in crypt {
            let encryptString = encrypt(s: c, solution: solutionDict)
            if encryptString[encryptString.startIndex] == "0" && encryptString.characters.count > 1 {
                return false
            }
            encryptedArray.append(Int("\(encryptString)")!)
        }
        
        return encryptedArray[0] + encryptedArray[1] == encryptedArray[2]
    }
    
    internal func encrypt(s: String, solution: [String: String]) -> String {
        var result = ""
        for c in s.characters {
            result = result.appending(solution["\(c)"]!)
        }
        
        return result
    }
    
    // ==========================================

    func rotateImage(a: inout [[Int]]) -> [[Int]] {
        if a.count <= 1 {
            return a
        }
        for n in 0...a.count - 2 {
            for m in n + 1...a.count - 1 {
                swap(&a[n][m], &a[m][n])
            }
        }
        for n in 0..<a.count {
            for m in 0..<a.count / 2 {
                if m != a.count - 1 - m {
                    swap(&a[n][m], &a[n][a.count - 1 - m])
                }
            }
        }
        
        return a
    }
    
    // ==========================================
    
    func sudoku2(grid: [[Character]]) -> Bool {
        var set = Set<String>()
        for r in 0..<grid.count{
            for c in 0..<grid.count {
                if grid[r][c] != "." {
                    let rowString = "row \(r) - value: \(grid[r][c])"
                    let colString = "col \(c) - value: \(grid[r][c])"
                    let subArrayString = "sub [\(r/3)|\(c/3)] - value: \(grid[r][c])"
                    if set.contains(rowString) ||  set.contains(colString) || set.contains(subArrayString){
                        return false
                    } else {
                        set.insert(rowString)
                        set.insert(colString)
                        set.insert(subArrayString)
                    }
                }
            }
        }
        
        return true
    }
    
    // *****************************************
    
    func printList(l: ListNode<Int>?) {
        var ptr = l
        print("[", terminator:"")
        while ptr != nil {
            print("\((ptr?.value)!), ", terminator:"")
            ptr = ptr?.next
        }
        print("]")
    }
    
    // ==========================================
    
    func removeKFromList(l: ListNode<Int>?, k: Int) -> ListNode<Int>? {
        var pointer = l
        
        // remove all node with value k in list (except head node)
        while pointer != nil && pointer?.next != nil{
            if pointer?.next?.value == k {
                pointer?.next = pointer?.next?.next
                
            } else {
                pointer = pointer?.next
            }
        }
        
        // check if head node has value k
        return l?.value == k ? l?.next : l
    }
    
    // ==========================================
    
    func isListPalindrome(l: ListNode<Int>?) -> Bool {
        var slowPtr = l, fastPtr = l,
        secondHalf: ListNode<Int>? = nil,
        prevOfSlowPtr = l, res = true
        
        if l != nil && l?.next != nil {
            /* Get the middle of the list. Move slow_ptr by 1
             and fast_ptrr by 2, slow_ptr will have the middle
             node */
            while fastPtr != nil && fastPtr?.next != nil {
                fastPtr = fastPtr?.next?.next
                
                /*We need previous of the slow_ptr for
                 linked lists  with odd elements */
                prevOfSlowPtr = slowPtr
                slowPtr = slowPtr?.next
            }
            
            /* fast_ptr would become NULL when there are even elements in list.
             And not NULL for odd elements. We need to skip the middle node
             for odd case and store it somewhere so that we can restore the
             original list*/
            if fastPtr != nil {
                slowPtr = slowPtr?.next
            }
            
            // Now reverse the second half and compare it with first half
            secondHalf = slowPtr
            prevOfSlowPtr?.next = nil
            reverseList(l: &secondHalf)
            res = compareList(l: l, l2: secondHalf)
        }
        
        return res
    }
    
    // reverse list head->1->2->3->4 to be 1<-2<-3<-4<-head
    @discardableResult
    internal func reverseList(l: inout ListNode<Int>?) -> Int{
        var prev: ListNode<Int>? = nil,
        current = l,
        next: ListNode<Int>? = nil,
        length = 0
        
        while current != nil {
            next = current?.next
            current?.next = prev
            prev = current
            current = next
            length = length + 1
        }
        l = prev
        
        return length
    }
    
    internal func compareList(l: ListNode<Int>?, l2: ListNode<Int>?) -> Bool {
        var temp1 = l
        var temp2 = l2
        
        while temp1 != nil && temp2 != nil {
            if temp1?.value == temp2?.value {
                temp1 = temp1?.next
                temp2 = temp2?.next
                
            } else {
                return false
            }
        }
        
        if temp1 == nil && temp2 == nil {
            return true
        }
        
        return false
    }
    
    // ==========================================
    
    func addTwoHugeNumbers(a: ListNode<Int>?, b: ListNode<Int>?) -> ListNode<Int>? {
        var l1 = a, l2 = b, result: ListNode<Int>? = nil
        let length1 = reverseList(l: &l1), length2 = reverseList(l: &l2)
        if length1 > length2 {
            result = findSum(l1: &l1, l2: &l2)
            
        } else {
            result = findSum(l1: &l2, l2: &l1)
        }
        
        return result
    }
    
    internal func findSum(l1: inout ListNode<Int>?, l2: inout ListNode<Int>?) -> ListNode<Int>? {
        var temp1 = l1, temp2 = l2, carry = 0
        let m = 10000
        while temp1 != nil && temp2 != nil {
            let sum = (temp1?.value)! + (temp2?.value)! + carry
            temp1?.value = sum % m
            carry = sum / m
            if carry > 0 && temp1?.next == nil {
                temp1?.next = ListNode<Int>(0)
            }
            temp1 = temp1?.next
            temp2 = temp2?.next
        }
        while carry > 0 {
            let sum = (temp1?.value)! + carry
            temp1?.value = sum % m
            carry = sum / m
            if carry > 0 && temp1?.next == nil {
                temp1?.next = ListNode<Int>(0)
            }
            temp1 = temp1?.next
        }
        reverseList(l: &l1)
        
        return l1
    }
    
    // ==========================================
    
    func mergeTwoLinkedLists(l1: ListNode<Int>?, l2: ListNode<Int>?) -> ListNode<Int>? {
        if l1 == nil && l2 == nil {
            return nil
        }
        
        var result = ListNode<Int>(0),
        ptr = result,
        a = l1,
        b = l2
        
        while a != nil && b != nil {
            var minVal = (a?.value)!
            if minVal > (b?.value)! {
                minVal = (b?.value)!
                b = b?.next
                
            } else {
                a = a?.next
            }
            ptr.value = minVal
            ptr.next = ListNode<Int>(0)
            ptr = ptr.next!
        }
        
        if a != nil {
            ptr.value = (a?.value)!
            ptr.next = a?.next
            
        } else if b != nil {
            ptr.value = (b?.value)!
            ptr.next = b?.next
        }
        
        return result
    }
    
    // ==========================================
    
    func reverseNodesInKGroups(l: ListNode<Int>?, k: Int) -> ListNode<Int>? {
        if k == 1 {
            return l
        }
        
        var result = l, head = l, tail = l,
        nextHead = l, prevTail = l,
        count = 1
        while tail != nil{
            if count % k == 0 {
                nextHead = tail?.next
                tail?.next = nil
                tail = head
                reverseList(l: &head)
                tail?.next = nextHead
                if count == k {
                    result = head
                    
                } else {
                    prevTail?.next = head
                }
                
                prevTail = tail
                head = nextHead
            }
            tail = tail?.next
            count = count + 1
        }
        
        return result
    }
    
    // ==========================================
    
    func rearrangeLastN(l: ListNode<Int>?, n: Int) -> ListNode<Int>? {
        if n == 0 {
            return l
        }
        
        var result = l
        let length = reverseList(l: &result)
        if length == n {
            reverseList(l: &result)
            return result
        }
        
        var head = result,
        tail = result,
        nextHead = result,
        count = 1
        
        while tail != nil {
            if count == n {
                nextHead = tail?.next
                tail?.next = nil
                tail = head
                reverseList(l: &head)
                result = head
                
                reverseList(l: &nextHead)
                tail?.next = nextHead
                
                return result
            }
            tail = tail?.next
            count = count + 1
        }
        
        return l
    }
    
}
