//
//  AhoCorasickAlgorithm.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 8/12/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class AhoCorasickAlgorithm {
    
    func search(patterns: [String], inText text: String) -> [Int] {
        let result = [Int]()
        
        let trie = Trie()
        for pat in patterns {
            trie.insert(word: pat)
        }
        
        
        
        return result
    }
    
}
