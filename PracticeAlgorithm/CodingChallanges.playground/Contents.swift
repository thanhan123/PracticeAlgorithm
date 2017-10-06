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
//    return Set(characterOnly.characters) == Set(characterOnly2.characters) && characterOnly.characters.count == characterOnly2.characters.count
    
    let array = Array(input.characters),
    array2 = Array(input2.characters)
    return array.sorted() == array2.sorted()
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

// 11 - Three different letters
func hasAtmostThreeDifferentLetters(s: String, s2: String) -> Bool{
    let array = Array(s), array2 = Array(s2)
    if array.count != array2.count { return false }
    var result = 0
    for i in 0..<array.count {
        if array[i] != array2[i] {
            result += 1
            if result > 3 { return false }
        }
    }
    return true
}

hasAtmostThreeDifferentLetters(s: "Clamp", s2: "Cramp")
hasAtmostThreeDifferentLetters(s: "Clamp", s2: "Crams")
hasAtmostThreeDifferentLetters(s: "Clamp", s2: "Grams")
hasAtmostThreeDifferentLetters(s: "Clamp", s2: "Grans")
hasAtmostThreeDifferentLetters(s: "Clamp", s2: "Clam")
hasAtmostThreeDifferentLetters(s: "clamp", s2: "maple")

// 12 - Find longest prefix
func findLongestPrefix(of s: String) -> String {
    let words = s.components(separatedBy: " ")
    guard let first = words.first else { return "" }
    var currPrefix = "", bestPrefix = ""
    for letter in first.characters {
        currPrefix.append(letter)
        for word in words {
            if !word.hasPrefix(currPrefix) {
                return bestPrefix
            }
        }
        bestPrefix = currPrefix
    }
    return bestPrefix
}

findLongestPrefix(of: "swift switch swill swim")
findLongestPrefix(of: "flip flap flop")

// 13 - Run-length encoding
func getRunLengthEncoding(of s: String) -> String {
//    var result = "", count = 1, arrayS = Array(s)
//    for i in 0..<arrayS.count {
//        if i == arrayS.count - 1 || arrayS[i] != arrayS[i + 1] {
//            result.append("\(String(arrayS[i]) + String(count))")
//            count = 1
//        } else {
//            count += 1
//        }
//    }
//    return result
    
    var currLetter: Character?,
    result = "",
    letterCount = 0
    for c in s {
        if c == currLetter {
            letterCount += 1
        } else {
            if let currL = currLetter {
                result.append("\(currL)\(letterCount)")
            }
            letterCount = 1
            currLetter = c
        }
    }
    if let currL = currLetter {
        result.append("\(currL)\(letterCount)")
    }
    return result
}

getRunLengthEncoding(of: "aabbcc")
getRunLengthEncoding(of: "aaabaaabaaa")
getRunLengthEncoding(of: "aaAAaa")
getRunLengthEncoding(of: "swift switch swill swim")
getRunLengthEncoding(of: "flip flap flop")

// 14 - String permutations
func getPermutations(of s: String, current: String = "") {
    let length = s.characters.count,
    strArray = Array(s)
    
    if length == 0 {
        print(current)
    } else {
        for i in 0..<length {
            let left = String(strArray[0..<i]),
            right = String(strArray[i+1..<length])
            getPermutations(of: left + right, current: current + String(strArray[i]))
        }
    }
    
}

getPermutations(of: "a")
//print("*******************")
//getPermutations(of: "ab")
//print("*******************")
getPermutations(of: "abc")
print("*******************")
//getPermutations(of: "wombat")

// 15 - Reverse the words
func reverseWord(of s: String) -> String {
    let arrayWord = s.components(separatedBy: " ")
    
//    var result = arrayWord.reduce("") {
//        $0.appending(String($1.reversed()) + " ")
//    }
//    return String(result.dropLast())
    
    let reversedWord = arrayWord.map { String($0.reversed()) }
    return reversedWord.joined(separator: " ")
}

reverseWord(of: "Swift Coding Challenges")
reverseWord(of: "The quick brown fox")

// Mark - Number

// 16 - Fizz Buzz
func printFizzBuzz() {
//    for i in 1...100 {
//        if i % 15 == 0 {
//            print("Fizz Buzz")
//        } else if i % 3 == 0 {
//            print("Fizz")
//        } else if i % 5 == 0 {
//            print("Buzz")
//        } else {
//            print("\(i)")
//        }
//    }
    (1...100).forEach { print($0 % 3 == 0 ? $0 % 5 == 0 ? "Fizz Buzz" : "Fizz" : $0 % 5 == 0 ? "Buzz" : "\($0)") }
}

printFizzBuzz()
print("*******************")

// 17 - Random number
func getRandomNumber(from min: Int, to max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max - min + 1))) + min
}

getRandomNumber(from: 1, to: 5)
getRandomNumber(from: 8, to: 10)
getRandomNumber(from: 12, to: 12)
getRandomNumber(from: 12, to: 18)

// 18 - Recreate pow() function
func myPow(n: Int, n2: Int) -> Int {
    guard n > 0, n2 > 0 else { return 0 }
    let numbers = [Int](repeating: n, count: n2)
    return numbers.reduce(1, { $0*$1 })
}

myPow(n: 2, n2: 8)
myPow(n: 4, n2: 3)

// 19 - Swap 2 numbers without using temporary variable
func swapTwoNumbers(n: inout Int, n2: inout Int) {
//    n2 = n + n2
//    n = n2 - n
//    n2 = n2 - n
    
    (n, n2) = (n2, n)
}

var a = 3, b = 5
print("\(a), \(b)")
swapTwoNumbers(n: &a, n2: &b)
print("\(a), \(b)")
print("*******************")

// 20 - Number is prime
func isPrime(number: Int) -> Bool{
    guard number > 1 else { return false }
    if number == 2 { return true }
    for i in 2...Int(sqrt(Double(number))) {
        if number % i == 0 { return false }
    }
    return true
}

isPrime(number: 11)
isPrime(number: 13)
isPrime(number: 4)
isPrime(number: 9)
isPrime(number: 16777259)

// 21 - Couting binary ones
func getNextHighestAndLowestHaveSameNumberBits1(with number: Int) -> (highest: Int?, lowest: Int?){
    let binaryString = String(number, radix: 2)
    let numberOfOnes = binaryString.characters.reduce(0) { $1 == "1" ? $0 + 1 : $0 }
    
    return (0, 1)
}
