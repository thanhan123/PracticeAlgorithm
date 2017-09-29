//
//  AhoCorasickAlgorithm.swift
//  PracticeAlgorithm
//
//  Created by Dinh Thanh An on 8/12/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

class AhoCorasickAlgorithm {
    var out = [Int](repeating: 0, count: 500),
    f = [Int](repeating: 0, count: 500),
    g = [[Int]](repeating: [Int](repeating:  -1, count: 52), count: 500),
    alphabetIndex: [String: Int] = ["a": 0, "b": 1, "c": 2, "d": 3, "e": 4, "f": 5, "g": 6, "h": 7, "i": 8, "j": 9, "k": 10, "l": 11, "m": 12, "n": 13, "o": 14, "p": 15, "q": 16, "r": 17, "s": 18, "t": 19, "u": 20, "v": 21, "w": 22, "x": 23, "y": 24, "z": 25, "A": 26, "B": 27, "C": 28, "D": 29, "E": 30, "F": 31, "G": 32, "H": 33, "I": 34, "J": 35, "K": 36, "L": 37, "M": 38, "N": 39, "O": 40, "P": 41, "Q": 42, "R": 43, "S": 44, "T": 45, "U":46, "V": 47, "W": 48, "X": 49, "Y": 50, "Z": 51]
    
//    func search(patterns: [String], inText text: String) -> [Int] {
//        let result = [Int]()
//
//        let trie = Trie()
//        for pat in patterns {
//            trie.insert(word: pat)
//        }
//
//
//
//        return result
//    }
    
    internal func buildMatchingMachine(_ arr: [String], _ k: Int) -> Int {
        // Initially, we just have the 0 state
        var states = 1
        
        // Construct values for goto function, i.e., fill g[][]
        // This is same as building a Trie for arr[]
        for i in 0..<k {
            let word = arr[i]
            var currentState = 0
            
            // Insert all characters of current word in arr[]
            for j in 0..<word.characters.count {
                let ch = alphabetIndex[String(word[j])]! - alphabetIndex["a"]!
                
                // Allocate a new node (create a new state) if a
                // node for ch doesn't exist.
                if (g[currentState][ch] == -1) {
                    g[currentState][ch] = states
                    states += 1
                }
                // Add current word in output function
                currentState = g[currentState][ch];
            }
            out[currentState] = i
        }
        
        // For all characters which don't have an edge from
        // root (or state 0) in Trie, add a goto edge to state
        // 0 itself
        for ch in 0..<52 {
            if (g[0][ch] == -1) {
                g[0][ch] = 0
            }
        }
        
        // Now, let's build the failure function
        
        // Failure function is computed in breadth first order
        var q = [Int]()
        
        // Iterate over every possible input
        for ch in 0..<52{
            // All nodes of depth 1 have failure function value
            // as 0. For example, in above diagram we move to 0
            // from states 1 and 3.
            if (g[0][ch] != 0)
            {
                f[g[0][ch]] = 0;
                q.append(g[0][ch])
            }
        }
        
        // Now queue has states 1 and 3
        while (q.count > 0)
        {
            // Remove the front state from queue
            let state = q[0]
            q.removeFirst()
            
            // For the removed state, find failure function for
            // all those characters for which goto function is
            // not defined.
            for ch in 0..<52 {
                // If goto function is defined for character 'ch'
                // and 'state'
                if (g[state][ch] != -1)
                {
                    // Find failure state of removed state
                    var failure = f[state]
                    
                    // Find the deepest node labeled by proper
                    // suffix of string from root to current
                    // state.
                    while (g[failure][ch] == -1) {
                        failure = f[failure]
                    }
                    
                    failure = g[failure][ch];
                    f[g[state][ch]] = failure;
                    
                    // Merge output values
                    out[g[state][ch]] |= out[failure];
                    
                    // Insert the next level node (of Trie) in Queue
                    q.append(g[state][ch])
                }
            }
        }
        
        return states
    }
    
    // Returns the next state the machine will transition to using goto
    // and failure functions.
    // currentState - The current state of the machine. Must be between
    //                0 and the number of states - 1, inclusive.
    // nextInput - The next character that enters into the machine.
    internal func findNextState(_ currentState: Int, _ nextInput: Character) -> Int {
        var answer = currentState
        let ch = alphabetIndex[String(nextInput)]! - alphabetIndex["a"]!
        
        // If goto is not defined, use failure function
        while (g[answer][ch] == -1) {
            answer = f[answer];
        }
        
        return g[answer][ch]
    }
    
    // This function finds all occurrences of all array words
    // in text.
    func searchWords(_ arr: [String], _ k: Int, _ text: String) -> String {
        // Preprocess patterns.
        // Build machine with goto, failure and output functions
        _ = buildMatchingMachine(arr, k);
    
        // Initialize current state
        var currentState = 0
        
        var minPos = Int.max, endPos = -1,
        longestPart = ""
        // Traverse the text through the nuilt machine to find
        // all occurrences of words in arr[]
        for i in 0..<text.characters.count {
            currentState = findNextState(currentState, text[i])
        
            // If match not found, move to next state
            if (out[currentState] == 0) { continue }
            
            // Match found, print all matching words of arr[]
            // using output function.
            for j in 0..<k {
                if (out[currentState] & (1<<j)) == (1<<j) &&
                        (arr[j].characters.count > longestPart.characters.count ||
                        (arr[j].characters.count == longestPart.characters.count &&
                            i - arr[j].characters.count + 1 < minPos))
                {
                    minPos = i - arr[j].characters.count + 1;
                    endPos = i;
                    longestPart = arr[j];
                }
            }
        }
        
        if (endPos != -1) {
            var stringResult = text
            stringResult.replaceSubrange(stringResult.range(of: longestPart)!, with: "[\(longestPart)]")
            return stringResult
        }
        return text
    }
    
}
