//
//  Trie.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 8/12/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class Trie {
    class TrieNode {
        var map: [String: TrieNode] = [String: TrieNode]()
        var endOfWord = false
    }
    
    var root: TrieNode
    
    init() {
        root = TrieNode()
    }
    
//    func printTrieFrom(current: TrieNode?) {
//        if let current =  current {
//            dump(current.map)
//            if let map = current.map {
//                for (_, trie) in map {
//                    printTrieFrom(current: trie)
//                }
//            }
//        }
//    }
    
    func insert(word: String) {
        var current = root
        for i in 0..<word.characters.count {
            let char = word[i]
            var childNode = current.map["\(char)"]
            if childNode == nil {
                childNode = TrieNode()
                current.map["\(char)"] = childNode
            }
            current = childNode!
        }
        
        current.endOfWord = true
    }
    
    func insertRecursive(word: String) {
        insertRecursive(word: word, current: root, index: 0)
    }
    
    private func insertRecursive(word: String, current: TrieNode, index: Int) {
        if index == word.characters.count {
            current.endOfWord = true
            return
        }
        
        let char = word[index]
        var childNode = current.map["\(char)"]
        if childNode == nil {
            childNode = TrieNode()
            current.map["\(char)"] = childNode
        }
        
        insertRecursive(word: word, current: childNode!, index: index + 1)
    }
    
    func search(word: String) -> Bool{
        var current = root
        for i in 0..<word.characters.count {
            let char = word[i]
            let childNode = current.map["\(char)"]
            if childNode == nil {
                return false
            }
            current = childNode!
        }
        
        return current.endOfWord
    }
    
    func searchRecursive(word: String) -> Bool {
        return searchRecursive(word: word, current: root, index: 0)
    }
    
    private func searchRecursive(word: String, current: TrieNode, index: Int) -> Bool {
        if index == word.characters.count {
            return current.endOfWord
        }
        
        let char = word[index]
        let childNode = current.map["\(char)"]
        if childNode == nil {
            return false
        }
        
        return searchRecursive(word: word, current: childNode!, index: index + 1)
    }
    
    func delete(word: String) {
        delete(word: word, current: root, index: 0)
    }
    
    @discardableResult
    private func delete(word: String, current: TrieNode, index: Int) -> Bool {
        if index == word.characters.count {
            if current.endOfWord == false {
                return false
            }
            current.endOfWord = false
            return current.map.count == 0
        }
        
        let char = word[index]
        let childNode = current.map["\(char)"]
        if childNode == nil {
            return false
        }
        
        let shouldDeleteCurrent = delete(word: word, current: childNode!, index: index + 1)
        
        if shouldDeleteCurrent == true {
            current.map.removeValue(forKey: "\(char)")
            return current.map.count == 0
        }
        
        return false
    }
}
