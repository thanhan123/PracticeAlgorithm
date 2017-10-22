//: Playground - noun: a place where people can play

import UIKit

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

protocol NickName {
    var nickName: String { get set }
}

struct Person: FullyNamed, NickName{
    var fullName: String
    var nickName: String
}

let an = Person(fullName: "Dinh Thanh An", nickName: "An123")
print(an.fullName + " - " + an.nickName)

// ----------

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
print(ncc1701.fullName)

// ---------------------

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.37464991998171"
print("And another one: \(generator.random())")
// Prints "And another one: 0.729023776863283"


// --------------------

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

// -------------------

protocol SomeProtocol2 {
    init(someParameter: Int)
}

class SomeClass: SomeProtocol2 {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}


// ----------------------

protocol SomeProtocol3 {
    init()
}

class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol3 {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}

// -----------------------

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

// -----------------------

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

// -----------------------
protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

extension SnakesAndLadders: TextRepresentable{
    var textualDescription: String {
         return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}

print(game.textualDescription)

// -----------------------

struct Hamster{
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

// --------------------

let things: [TextRepresentable] = [game, d12, simonTheHamster]
for thing in things {
    print(thing.textualDescription)
}

// ---------------------

protocol PrettyTextRepresentable: TextRepresentable{
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        
        return output
    }
}

print(game.prettyTextualDescription)

// ----------------------

protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person2: Named, Aged, TextRepresentable {
    var name: String
    var age: Int
    var textualDescription: String
}
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person2(name: "An", age: 24, textualDescription: "AAA")
wishHappyBirthday(to: birthdayPerson)


//class Location {
//    var latitude: Double
//    var longitude: Double
//    init(latitude: Double, longitude: Double) {
//        self.latitude = latitude
//        self.longitude = longitude
//    }
//}
//class City: Location, Named {
//    var name: String
//    init(name: String, latitude: Double, longitude: Double) {
//        self.name = name
//        super.init(latitude: latitude, longitude: longitude)
//    }
//}
//func beginConcert(in location: Location & Named) {
//    print("Hello, \(location.name)!")
//}
//
//let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
//beginConcert(in: seattle)

// -----------------------

protocol HasArea {
    var area: Double { get }
}
class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}

// ---------------

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}
class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}

// --------------------- 

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}
let generator2 = LinearCongruentialGenerator()
print("Here's a random number: \(generator2.random())")
print("And here's a random Boolean: \(generator2.randomBool())")

extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]
print(hamsters.textualDescription)


// *************** Generic protocol
// Using Self
//protocol MythicalType {
//    func holdAMeetingWithTheClan(clan: [Self])
//}
//
//final class Kraken: MythicalType {
////    func holdAMeetingWithTheClan(clan: [Kraken]) {
////
////    }
//}
//
//final class Elf: MythicalType {
//    func holdAMeetingWithTheClan(clan: [Elf]) {
//
//    }
//}
//
//extension MythicalType where Self: Kraken {
//    func holdAMeetingWithTheClan(clan: [Kraken]) {
//
//    }
//}

// Using associatedType
protocol MythicalType: class {
    associatedtype FoodType
    
    var lastEatenFood: FoodType { get set }
    
    func prepareFood() -> [FoodType]
    func devour(edible: FoodType)
}

//class Kraken: MythicalType {
//    func prepareFood() -> [Human] {
//        return village.inhabitants
//    }
//
//    func devour(edible: Human) {
//
//    }
//}
//
//class Elf: MythicalType {
//    func prepareFood() -> [Vegetable] {
//        return gatherCrops(nearbyFarm)
//    }
//
//    func devour(edible: Vegetable) {
//
//    }
//}

private extension MythicalType {
    func setLastEatenFood(food: FoodType) {
        lastEatenFood = food
    }
    
    func getLastEatenFood() -> FoodType {
        return lastEatenFood
    }
}

class Storybook<T: MythicalType> {}

func writeBookAbout<T: MythicalType>(myth: T) {}

class AnyMythicalType<T>: MythicalType {
    private let _prepareFood: (() -> [T])
    private let _devour: ((T) -> Void)
    
    var lastEatenFood: T {
        get { return _getLastEatenFood() }
        set { _setLastEatenFood(newValue) }
    }
    private let _getLastEatenFood: (() -> T)
    private let _setLastEatenFood: ((T) -> Void)
    
    required init<U: MythicalType>(_ mythicalCreature: U) where U.FoodType == T {
        _prepareFood = mythicalCreature.prepareFood
        _devour = mythicalCreature.devour
        _getLastEatenFood = mythicalCreature.getLastEatenFood
        _setLastEatenFood = mythicalCreature.setLastEatenFood
    }
    
    func prepareFood() -> [T] {
        return _prepareFood()
    }
    
    func devour(edible: T) {
        _devour(edible)
    }
}

//let kraken = Kraken()
//
//let mythicalCreature: AnyMythicalType<Human>
//
//mythicalCreature = AnyMythicalType(kraken)







