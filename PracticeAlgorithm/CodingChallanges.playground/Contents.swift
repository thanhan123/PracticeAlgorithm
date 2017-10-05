//: Playground - noun: a place where people can play

import UIKit

// Mark - String

// 1 - Are the letters unique?
func isStringContainUniqueLetter(input: String) -> Bool {
    return Set(input.characters).count == input.characters.count
}

isStringContainUniqueLetter(input: "No duplicates")
isStringContainUniqueLetter(input: "abcdefghijklmnopqrstuvwxyz")
isStringContainUniqueLetter(input: "AaBbCc")
isStringContainUniqueLetter(input: "Hello, world")

// 2 - Is a string palindrome?
func isStringPalindrome(input: String) -> Bool {
    let lowercaseString = input.lowercased()
    return lowercaseString.characters.reversed() == Array(lowercaseString.characters)
}

isStringPalindrome(input: "rotator")
isStringPalindrome(input: "Rats live on no evil star")
isStringPalindrome(input: "Never odd or even")
isStringPalindrome(input: "Hello, world")

// 3 - Do two strings contain the same characters?
func doTwoStringContainSameCharacters(input: String, input2: String) -> Bool {
//    let characterOnly = input.replacingOccurrences(of: " ", with: ""),
//    characterOnly2 = input2.replacingOccurrences(of: " ", with: "")
//
//    return Set(characterOnly.characters) == Set(characterOnly2.characters) && characterOnly.characters.count == characterOnly2.characters.count
    
    let array = Array(input.characters),
    array2 = Array(input2.characters)
    return array.count == array2.count &&
        array.sorted() == array2.sorted()
}

doTwoStringContainSameCharacters(input: "abca", input2: "abca")
doTwoStringContainSameCharacters(input: "abc", input2: "cba")
doTwoStringContainSameCharacters(input: "a1 b2", input2: "b1 a2")
doTwoStringContainSameCharacters(input: "a1 b2", input2: "b 1 a 2")
doTwoStringContainSameCharacters(input: "abc", input2: "abca")
doTwoStringContainSameCharacters(input: "abc", input2: "Abc")
doTwoStringContainSameCharacters(input: "abc", input2: "cbAa")

// 4 - Does one string contain another?
extension String {
    func fuzzyContains(_ string: String) -> Bool {
        return self.range(of: string, options: .caseInsensitive) != nil
    }
}

"Hello, world".fuzzyContains("Hello")
"Hello, world".fuzzyContains("WORLD")
"Hello, world".fuzzyContains("Goodbye")

// 5 - Count the characters
func countCharacter(_ character: Character, inString string: String) -> Int {
//    var count = 0
//    for c in string {
//        if c == character {
//            count+=1
//        }
//    }
//    return count
    
//    return string.characters.reduce(0, {
//        $1 == character ? $0 + 1 : $0
//    })
    
//    let array = string.characters.map{ String($0) },
//     counted = NSCountedSet(array: array)
//    return counted.count(for: character)
    
//    let nonSpecificCharaterString = string.replacingOccurrences(of: "\(character)", with: "")
//    return string.characters.count - nonSpecificCharaterString.characters.count
    
    let result = string.characters.filter{
        $0 == character
    }
    return result.count
}

countCharacter("a", inString: "The rain in Spain")
countCharacter("i", inString: "Mississippi")
countCharacter("i", inString: "Hacking with Swift")

// 6 - Remove duplicate letters from a string
func removeDuplicateCharacterIn(_ string: String) -> String{
    
    var used = [Character: Bool]()
    
    let result = string.characters.filter {
        used.updateValue(true, forKey: $0) == nil
    }
    
    return String(result)
}

removeDuplicateCharacterIn("wombat")
removeDuplicateCharacterIn("hello")
removeDuplicateCharacterIn("Mississippi")

// 7 - Condense whitespace
func condenseWhitespaceOf(string: String) -> String {
//    var temp = string
//    for i in (1..<temp.characters.count).reversed() {
//        if temp[temp.index(temp.startIndex, offsetBy: i)] == " " &&
//            temp[temp.index(temp.startIndex, offsetBy: i - 1)] == " " {
//            temp.remove(at: temp.index(string.startIndex, offsetBy: i))
//        }
//    }
//    return temp
    
//    var seenPlace = false, result = ""
//    for c in string {
//        if c == " " {
//            if seenPlace { continue }
//            seenPlace = true
//        } else {
//            seenPlace = false
//        }
//        result.append(c)
//    }
//    return result
    
    return string.replacingOccurrences(of: " +", with: " ", options: .regularExpression)
}

condenseWhitespaceOf(string: "a   b   c")
condenseWhitespaceOf(string: "    a")
condenseWhitespaceOf(string: "abc")

// 8 - String is rotated
func isTwoStringRotated(string: String, string2: String) -> Bool {
    if Set(string) != Set(string2) {
        return false
    }
    let doulbeString = string + string
    return doulbeString.contains(string2)
}

isTwoStringRotated(string: "abcde", string2: "eabcd")
isTwoStringRotated(string: "abcde", string2: "cdeab")
isTwoStringRotated(string: "abcde", string2: "abced")
isTwoStringRotated(string: "abc", string2: "a")

// 9 - Find pangrams
func isPangrams(_ string: String) -> Bool {
    let set = Set(string.lowercased())
    let letters = set.filter {
        $0 >= "a" && $0 <= "z"
    }
    return letters.count == 26
}

isPangrams("The quick brown fox jumps over the lazy dog")
isPangrams("The quick brown fox jumped over,. the lazy dog")

// 10 - Vowels and consonants
func getNumberOfVowelsAndConsonants(of string: String) -> (vowels: Int, consonants: Int) {
    let vowelsString = "aeiou",
    letters = string.lowercased().filter {
        $0 >= "a" && $0 <= "z"
    }
    let vowelsCount = letters.reduce(0) { vowelsString.contains($1) ? $0 + 1 : $0 }
    return (vowelsCount, letters.characters.count - vowelsCount)
}

getNumberOfVowelsAndConsonants(of: "Swift Coding Challenges")
getNumberOfVowelsAndConsonants(of: "Mississippi")
