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

// Definition for binary tree:
 public class Tree<T> {
     public var value: T
     public var left: Tree<T>?
     public var right: Tree<T>?
     public init(_ x: T) {
         self.value = x
         self.left = nil
         self.right = nil
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
                    a[n].swapAt(m, a.count - 1 - m)
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
        // reverse 2 lists
        let length1 = reverseList(l: &l1), length2 = reverseList(l: &l2)
        if length1 > length2 {
            result = findSum(l1: &l1, l2: &l2)
            
        } else {
            result = findSum(l1: &l2, l2: &l1)
        }
        
        return result
    }
    
    // get sum of 2 lists by adding one by one number in each node as mathemitcal in school
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
        
        var result = ListNode<Int>(0), // create result list
        ptr = result,
        a = l1,
        b = l2
        
        while a != nil && b != nil {
            var minVal = (a?.value)! // check min value between a.value and b.value
            if minVal > (b?.value)! {
                minVal = (b?.value)! // minor value is b.value -> move b to next value
                b = b?.next
                
            } else {
                a = a?.next // minor value is a.value -> move a to next value
            }
            ptr.value = minVal
            ptr.next = ListNode<Int>(0) // create next node
            ptr = ptr.next!
        }
        
        // merge result to the remaining list
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
    
    // l = 1->2->3->4->5->6->7; k = 3 ====> l = 3->2->2->6->5->4->7
    func reverseNodesInKGroups(l: ListNode<Int>?, k: Int) -> ListNode<Int>? {
        if k == 1 {
            return l
        }
        
        var result = l, head = l, tail = l,
        nextHead = l, prevTail = l,
        count = 1
        while tail != nil{
            if count % k == 0 { // came to the end of group
                nextHead = tail?.next
                tail?.next = nil // cut the list at tail node: ... head ->...-> tail ...
                tail = head // tail move to head to prepare for reversing list head ->...-> tail
                reverseList(l: &head) // reverse list from head and change head position
                tail?.next = nextHead
                if count == k {
                    result = head // if this is first group set result to be head
                    
                } else {
                    prevTail?.next = head // concatenate previous group to current group
                }
                
                prevTail = tail // set current group to be previous group
                head = nextHead // move head to new position (next postion of head)
            }
            tail = tail?.next
            count = count + 1
        }
        
        return result
    }
    
    // ==========================================
    
    // l = 1->2->3->4->5->6->7; n = 3 ====> l = 5->6->7->1->2->3->4
    func rearrangeLastN(l: ListNode<Int>?, n: Int) -> ListNode<Int>? {
        if n == 0 {
            return l
        }
        
        var result = l
        let length = reverseList(l: &result) // reverse list result = 7->6->5->4->3->2->1
        if length == n {
            reverseList(l: &result)
            return result
        }
        
        var head = result,
        tail = result,
        nextHead = result,
        count = 1
        
        while tail != nil {
            if count == n { // came to the end of the first group
                nextHead = tail?.next
                tail?.next = nil
                tail = head
                reverseList(l: &head)
                result = head
                // result = 5->6->7
                // nextHead = 4->3->2->1
                
                reverseList(l: &nextHead)
                // nextHead = 1->2->3->4
                tail?.next = nextHead
                // result = 5->6->7->1->2->3->4
                
                return result
            }
            tail = tail?.next
            count = count + 1
        }
        
        return l
    }
    
    // *****************************************
    
    func groupingDishes(dishes: [[String]]) -> [[String]] {
        var ingredientDict = [String: [String]]()
        for i in 0..<dishes.count {
            for j in 1..<dishes[i].count {
                if ingredientDict[dishes[i][j]] == nil {
                    ingredientDict[dishes[i][j]] = []
                }
                ingredientDict[dishes[i][j]]?.append(dishes[i][0])
            }
        }
        let groups =
        ingredientDict.filter { key, value -> Bool in
            value.count >= 2
        }.sorted { a, b -> Bool in
            a.key < b.key
        }
        var result = [[String]]()
        for (key, value) in groups {
            var group = value
            group.sort(by: { (a, b) -> Bool in
                a < b
            })
            group.insert(key, at: 0)
            result.append(group)
        }
        
        return result
    }
    
    // *****************************************
    
    func hasPathWithGivenSum(t: Tree<Int>?, s: Int) -> Bool {
        if t?.left == nil && t?.right == nil {
            return t?.value ?? 0 == s
        }
        return hasPathWithGivenSum(t: t, prevSum: 0, s: s)
    }
    
    internal func hasPathWithGivenSum(t: Tree<Int>?, prevSum: Int, s: Int) -> Bool {
        if t == nil {
            return prevSum == s
        }
        if hasPathWithGivenSum(t: t?.left, prevSum: (t?.value)! + prevSum, s: s) {
            if (t?.value)! != s || t?.left != nil  {
                return true
            }
        }
        if hasPathWithGivenSum(t: t?.right, prevSum: (t?.value)! + prevSum, s: s) {
            if (t?.value)! != s || t?.right != nil  {
                return true
            }
        }
        return false
    }
    
    // ==========================================
    
    func isTreeSymmetric(t: Tree<Int>?) -> Bool {
        return checkTwoTreesSymmetric(t: t?.left, t2: t?.right)
    }
    
    internal func checkTwoTreesSymmetric(t: Tree<Int>?, t2: Tree<Int>?) -> Bool {
        if t == nil && t2 == nil {
            return true
        }
        if t?.value != t2?.value {
            return false
        }
        return checkTwoTreesSymmetric(t: t?.left, t2: t2?.right) &&
               checkTwoTreesSymmetric(t: t?.right, t2: t2?.left)
    }
    
    // ==========================================
    
    func findProfession(level: Int, pos: Int) -> String {
        var tempPos = pos - 1, result = 0
        for _ in 1..<level {
            if tempPos % 2 != 0 {
                result = result + 1
            }
            tempPos = tempPos / 2
        }
        return result % 2 == 0 ? "Engineer" : "Doctor"
    }
    
    // ==========================================
    
    func kthLargestInBST(t: Tree<Int>?, k: Int) -> Int {
//        var count = 0, ksmall = Int.min, curr = t
//
//        while curr != nil {
//            if curr?.left == nil {
//                count = count + 1
//                if (count == k) {
//                    ksmall = (curr?.value)!
//                }
//                curr = curr?.right
//            } else {
//                var pre = curr?.left
//                while pre?.right != nil && pre?.right !== curr {
//                    pre = pre?.right
//                }
//                if pre?.right == nil {
//                    pre?.right = curr
//                    curr = curr?.left
//                } else {
//                    pre?.right = nil
//                    count = count + 1
//                    if count == k {
//                        ksmall = (curr?.value)!
//                    }
//                    curr = curr?.right
//                }
//            }
//        }
//
//        return ksmall
        
        // in-order traversal
        
        var i = 0, ret = 0
        
        func f(_ node: Tree<Int>?) {
            
            if let n = node {
                
                if let l = n.left { f(l) }
                
                i += 1
                
                if i == k { ret = n.value }
                
                if let r = n.right { f(r) }
            }
        }
        
        f(t)
        
        return ret
    }
    
    // ==========================================
    
    func isSubtree(t1: Tree<Int>?, t2: Tree<Int>?) -> Bool {
//        var inT1 = "", inT2 = "", preT1 = "", preT2 = ""
//        storeInOder(t: t1, s: &inT1)
//        storeInOder(t: t2, s: &inT2)
//
//        let kmpAlgo = KMPSearchSubStringAlgorithm()
//        if kmpAlgo.searchPattern(inT2, inText: inT1).count == 0 {
//            return false
//        }
//
//        storePreOder(t: t1, s: &preT1)
//        storePreOder(t: t2, s: &preT2)
//        return kmpAlgo.searchPattern(preT2, inText: preT1).count > 0
        
        if t2 == nil { return true }
        if t1 == nil { return false }
        if areIdentical(t1: t1, t2: t2) {
            return true
        }
        
        return isSubtree(t1: t1?.left, t2: t2) ||
               isSubtree(t1: t1?.right, t2: t2)
    }
    
    internal func areIdentical(t1: Tree<Int>?, t2: Tree<Int>?) -> Bool {
        if t1 == nil && t2 == nil {
            return true
        }
        
        if t1 == nil || t2 == nil {
            return false
        }
        
        return t1?.value == t2?.value &&
        areIdentical(t1: t1?.left, t2: t2?.left) &&
        areIdentical(t1: t1?.right, t2: t2?.right)
    }
    
    internal func storeInOder(t: Tree<Int>?, s: inout String) {
        if t == nil {
            s.append("$")
            return
        }
        storeInOder(t: t?.left, s: &s)
        s.append("\((t?.value)!)")
        storeInOder(t: t?.right, s: &s)
    }
    
    internal func storePreOder(t: Tree<Int>?, s: inout String) {
        if t == nil {
            s.append("$")
            return
        }
        s.append("\((t?.value)!)")
        storePreOder(t: t?.left, s: &s)
        storePreOder(t: t?.right, s: &s)
    }
    
    // ==========================================
    
    func restoreBinaryTree(inorder: [Int], preorder: [Int]) -> Tree<Int>? {
        var preorderIndex = 0
        return buildTree(inorder, preorder, 0, inorder.count - 1, &preorderIndex)
    }
    
    internal func buildTree(_ inorder: [Int], _ preorder: [Int],
                            _ inIndexStart: Int, _ inIndexEnd: Int, _ preIndex: inout Int) -> Tree<Int>? {
        if inIndexStart > inIndexEnd { return nil }
        let root = Tree<Int>(preorder[preIndex])
        preIndex+=1
        
        let inIndex = inorder.index(of: root.value)!
        
        root.left = buildTree(inorder, preorder, inIndexStart, inIndex - 1, &preIndex)
        root.right = buildTree(inorder, preorder, inIndex + 1, inIndexEnd, &preIndex)
        
        return root
    }
    
    // ==========================================
    
    func findSubstrings(words: [String], parts: [String]) -> [String] {
        let ahoCorAlgo = AhoCorasickAlgorithm()
        var res = [String]()
        for i in 0..<words.count {
            let text = words[i];
            res.append(ahoCorAlgo.searchWords(parts, parts.count, text))
        }
        return res;
    }

}
