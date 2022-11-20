import UIKit
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

func printDivider() {
    print("------------------------------------------------------")
}

// Converting Swift errors to NSError
if let url = URL(string: "https://www.sdlfkjdlskfjlkdsjf.com") {
    let task = URLSession(configuration: .default).dataTask(with: url) { data, _, error in
        switch error {
        case .some(let error as NSError) where error.code == NSURLErrorNotConnectedToInternet:
            print("11")
        case .some(let error):
            print("22")
        case .none:
            print("33")
        }
        
//        // second way
//        if let err = error {
//            switch err {
//            case URLError.notConnectedToInternet:
//                print("notConnectedToInternet")
//            case URLError.cannotConnectToHost:
//                print("cannotConnectToHost")
//            default:
//                print("err")
//            }
//        }
    }
//    task.resume()
}

printDivider()

enum RepeatMode {
    case times(Int)
    case forever
}

enum UpdateOutcome {
    case finished
}

class Test {
    var closure: () -> UpdateOutcome
    
    init(repeatMode: RepeatMode, closure: @escaping () -> UpdateOutcome) {
        // Shadow the argument with a local, mutable copy
        var repeatMode = repeatMode
        
        self.closure = {
            // With shadowing, there's no risk of accidentially
            // referring to the immutable version
            switch repeatMode {
            case .forever:
                break
            case .times(let count):
                guard count > 0 else {
                    return .finished
                }
                
                // We can now capture the mutable version and use
                // it for state in a closure
                repeatMode = .times(count - 1)
            }
            
            return closure()
        }
    }
}


// Since all optionals are actual enum values in Swift, we can easily
// extend them for certain types, to add our own convenience APIs

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        switch self {
        case let string?:
            return string.isEmpty
        case nil:
            return true
        }
    }
}

// Since strings are now Collections in Swift 4, you can even
// add this property to all optional collections:

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        switch self {
        case let collection?:
            return collection.isEmpty
        case nil:
            return true
        }
    }
}

let a:String? = nil
let b:Array? = [0, 2, 0, 4, 0, 3, 1, 0]

print(a.isNilOrEmpty)
print(b.isNilOrEmpty)


extension Equatable {
    func isAny(of candidates: Self...) -> Bool {
        return candidates.contains(self)
    }
}

enum Direction: Equatable {
    case left
    case right
    case up
    case down
}

let direction = Direction.left
let isHorizontal = direction.isAny(of: .left, .right)


// The cool thing is that you can easily define your own option
// sets as well, by defining a struct that has an Int rawValue,
// that will be used as a bit mask.
class Cache {
    struct Options: OptionSet {
        static let saveToDisk = Options(rawValue: 1)
        static let clearOnMemoryWarning = Options(rawValue: 1 << 1)
        static let clearDaily = Options(rawValue: 1 << 2)

        let rawValue: Int
    }
    
    init(options: Options) {
        
    }
}

// We can now use Cache.Options just like UIViewAnimationOptions:
Cache(options: .saveToDisk)
Cache(options: [.saveToDisk, .clearDaily])

// Struct convenience initializers
struct Article {
    let date: Date
    var title: String
    var text: String
    var comments: [Comment]
}

struct Comment {
    var user: String
    var text: String
}

extension Article {
    init(title: String, text: String) {
        self.init(date: Date(), title: title, text: text, comments: [])
    }
}

let articleA = Article(title: "Best Cupcake Recipe", text: "...")

let articleB = Article(
    date: Date(),
    title: "Best Cupcake Recipe",
    text: "...",
    comments: [
        Comment(user: "currentUser", text: "Yep, can confirm!")
    ]
)

// Assigning optional tuple members to variables
class ImageTransformer {
    private var queue = [(image: UIImage, transform: CGAffineTransform)]()

    private func processNext() {
        // When unwrapping an optional tuple, you can assign the members
        // directly to local variables.
        guard let (image, transform) = queue.first else {
            return
        }

//        let context = Context()
//        context.draw(image)
//        context.apply(transform)
//        ...
    }
}

//Creating a dedicated identifier type
struct Identifier: Hashable {
    let string: String
}

extension Identifier: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        string = value
    }
}

extension Identifier: CustomStringConvertible {
    var description: String {
        return string
    }
}

extension Identifier: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        string = try container.decode(String.self)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(string)
    }
}

struct Article2: Codable {
    let id: Identifier
    let title: String
}

let article = Article2(id: "my-article", title: "Hello world!")


// Using shared UserDefaults suites
let sharedDefaults = UserDefaults(suiteName: "my-app-group")!
let useDarkMode = sharedDefaults.bool(forKey: "dark-mode")
print("useDarkMode:\(useDarkMode)")
// This value is put into the shared suite.
sharedDefaults.set(true, forKey: "dark-mode")

// If you want to treat the shared settings as read-only (and add
// local overrides on top of them), you can simply add the shared
// suite to the standard UserDefaults.
let combinedDefaults = UserDefaults.standard
combinedDefaults.addSuite(named: "my-app-group")

// This value is a local override, not added to the shared suite.
combinedDefaults.set(true, forKey: "app-specific-override")


NSSetUncaughtExceptionHandler { exception in
    print(exception)
}

// Implementing the builder pattern with keypaths
protocol With {}

extension With where Self: AnyObject {
    @discardableResult
    func with<T>(_ property: ReferenceWritableKeyPath<Self, T>, setTo value: T) -> Self {
        self[keyPath: property] = value
        return self
    }
}

extension UIView: With {}

let view = UIView()

let label = UILabel()
    .with(\.textColor, setTo: .red)
    .with(\.text, setTo: "Foo")
    .with(\.textAlignment, setTo: .right)
    .with(\.layer.cornerRadius, setTo: 5)

view.addSubview(label)


// Easily generating arrays of data
func randomInt() -> Int { return Int(arc4random()) }

let randomArray = (1...10).map { _ in randomInt() }
print(randomArray)

 
// Writing an interruptible overload of forEach
extension Sequence {
    func forEach(_ body: (Element, _ stop: inout Bool) throws -> Void) rethrows {
        var stop = false
        for element in self {
            try body(element, &stop)
            
            if stop {
                return
            }
        }
    }
}

["Foo", "Bar", "FooBar"].forEach { element, stop in
    print(element)
    stop = (element == "Bar")
}

// Prints:
// Foo
// Bar

class Variable<Value> {
    var value: Value {
        didSet {
            onUpdate?(value)
        }
    }
    
    var onUpdate: ((Value) -> Void)? {
        didSet {
            onUpdate?(value)
        }
    }
    
    init(_ value: Value, _ onUpdate: ((Value) -> Void)? = nil) {
        self.value = value
        self.onUpdate = onUpdate
        self.onUpdate?(value)
    }
}

let variable: Variable<String?> = Variable(nil)

variable.onUpdate = { data in
    if let data = data {
        print(data)
    }
}

variable.value = "Foo1"
variable.value = "Bar1"

// prints:
// Foo1
// Bar1

// Solving callback hell with function composition
typealias CompletionHandler<Result> = (Result?, Error?) -> Void

infix operator ~>: MultiplicationPrecedence

func ~> <T, U>(_ first: @escaping (CompletionHandler<T>) -> Void, _ second: @escaping (T, CompletionHandler<U>) -> Void) -> (CompletionHandler<U>) -> Void {
    return { completion in
        first({ firstResult, error in
            guard let firstResult = firstResult else { completion(nil, error); return }
            
            second(firstResult, { (secondResult, error) in
                completion(secondResult, error)
            })
        })
    }
}

func ~> <T, U>(_ first: @escaping (CompletionHandler<T>) -> Void, _ transform: @escaping (T) -> U) -> (CompletionHandler<U>) -> Void {
    return { completion in
        first({ result, error in
            guard let result = result else { completion(nil, error); return }
            
            completion(transform(result), nil)
        })
    }
}

func service1(_ completionHandler: CompletionHandler<Int>) {
    print(#function)
    completionHandler(42, nil)
}

func service2(arg: String, _ completionHandler: CompletionHandler<String>) {
    print(#function)
    completionHandler("🎉 \(arg)", nil)
}

let chainedServices = service1
~> { int in
    print(#function);
    return String(int / 2)
}
~> service2

chainedServices({ result, _ in
    guard let result = result else { return }
    print(#function)
    print(result) // Prints: 🎉 21
})


printDivider()

// Getting rid of overabundant [weak self] and guard
protocol Weakifiable: class { }

extension Weakifiable {
    func weakify(_ code: @escaping (Self) -> Void) -> () -> Void {
        return { [weak self] in
            guard let self = self else { return }
            
            code(self)
        }
    }
    
    func weakify<T>(_ code: @escaping (T, Self) -> Void) -> (T) -> Void {
        return { [weak self] arg in
            guard let self = self else { return }
            
            code(arg, self)
        }
    }
}

extension NSObject: Weakifiable { }

class Producer: NSObject {
    
    deinit {
        print("deinit Producer")
    }
    
    private var handler: (Int) -> Void = { _ in }
    
    func register(handler: @escaping (Int) -> Void) {
        self.handler = handler
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { self.handler(42) })
    }
}

class Consumer: NSObject {
    
    deinit {
        print("deinit Consumer")
    }
    
    let producer = Producer()
    
    func consume() {
        producer.register(handler: weakify { result, strongSelf in
            strongSelf.handle(result)
        })
    }
    
    private func handle(_ result: Int) {
        print("🎉 \(result)")
    }
}

var consumer: Consumer? = Consumer()

consumer?.consume()
DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { consumer = nil })

// This code prints:
// 🎉 42
// deinit Consumer
// deinit Producer


// Lightweight dependency injection through protocol-oriented programming
protocol Formatting {
    var formatter: NumberFormatter { get }
}

private let sharedFormatter: NumberFormatter = {
    let sharedFormatter = NumberFormatter()
    sharedFormatter.numberStyle = .currency
    return sharedFormatter
}()

extension Formatting {
    var formatter: NumberFormatter { return sharedFormatter }
}

class ViewModel: Formatting {
    var displayableAmount: String?
    
    func updateDisplay(to amount: Double) {
        displayableAmount = formatter.string(for: amount)
    }
}

let viewModel = ViewModel()

viewModel.updateDisplay(to: 42000.45)
viewModel.displayableAmount // "$42,000.45"

//Another lightweight dependency injection through default values for function parameters
protocol Service {
    func call() -> String
}

class ProductionService: Service {
    func call() -> String {
        return "This is the production"
    }
}

class MockService: Service {
    func call() -> String {
        return "This is a mock"
    }
}

typealias Provider<T> = () -> T

class Controller {
    
    let service: Service
    
    init(serviceProvider: Provider<Service> = { return ProductionService() }) {
        self.service = serviceProvider()
    }
    
    func work() {
        print(service.call())
    }
}

let productionController = Controller()
productionController.work() // prints "This is the production"

let mockedController = Controller(serviceProvider: { return MockService() })
mockedController.work() // prints "This is a mock"

printDivider()

// Providing a default value to a Decodable enum
enum State: String, Decodable {
    case active
    case inactive
    case undefined
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let decodedString = try container.decode(String.self)
        print("decodedString:\(decodedString)")
        self = State(rawValue: decodedString) ?? .undefined
    }
}

let data = """
["active", "inactive", "foo"]
""".data(using: .utf8)!

let decoded = try! JSONDecoder().decode([State].self, from: data)

print(decoded) // [State.active, State.inactive, State.undefined]


// Using Never to represent impossible code paths
enum Result<Value, Error> {
    case success(value: Value)
    case failure(error: Error)
}

func willAlwaysSucceed(_ completion: @escaping ((Result<String, Never>) -> Void)) {
    completion(.success(value: "Call was successful"))
}

willAlwaysSucceed( { result in
    switch result {
    case .success(let value):
        print(value)
    // the compiler knows that the `failure` case cannot happen
    // so it doesn't require us to handle it.
    }
})


// Implementing a namespace through an empty enum
enum NumberFormatterProvider {
    static var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.roundingIncrement = 0.01
        return formatter
    }
    
    static var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = ","
        return formatter
    }
}

// 'NumberFormatterProvider' cannot be constructed because it has no accessible initializers
//NumberFormatterProvider() // ❌ impossible to instantiate by mistake

NumberFormatterProvider.currencyFormatter.string(from: 2.456) // $2.46
NumberFormatterProvider.decimalFormatter.string(from: 2.456) // 2,456


// Defining a custom init without loosing the compiler-generated one
struct Point {
    let x: Int
    let y: Int
}

extension Point {
    init() {
        x = 0
        y = 0
    }
}

let usingDefaultInit = Point(x: 4, y: 3)
let usingCustomInit = Point()

//Avoiding double negatives within guard statements
extension Collection {
    var hasElements: Bool {
        return !isEmpty
    }
}

let array = Bool.random() ? [1, 2, 3] : []

//guard array.hasElements else { fatalError("array was empty") }

//print(array)


import UIKit

@resultBuilder
class NSAttributedStringBuilder {
    static func buildBlock(_ components: NSAttributedString...) -> NSAttributedString {
        let result = NSMutableAttributedString(string: "")
        
        return components.reduce(into: result) { (result, current) in result.append(current) }
    }
}

extension NSAttributedString {
    class func composing(@NSAttributedStringBuilder _ parts: () -> NSAttributedString) -> NSAttributedString {
        return parts()
    }
}

//
//let result = NSAttributedString.composing {
//    NSAttributedString(string: "Hello",
//                       attributes: [.font: UIFont.systemFont(ofSize: 24),
//                                    .foregroundColor: UIColor.red])
//    NSAttributedString(string: " world!",
//                       attributes: [.font: UIFont.systemFont(ofSize: 20),
//                                    .foregroundColor: UIColor.orange])
//}


// Implementing pseudo-inheritance between structs
protocol Inherits {
    associatedtype SuperType
    
    var `super`: SuperType { get }
}

extension Inherits {
    subscript<T>(dynamicMember keyPath: KeyPath<SuperType, T>) -> T {
        print(keyPath)
        return self.`super`[keyPath: keyPath]
    }
}

struct Person {
    let name: String
}

@dynamicMemberLookup
struct User: Inherits {
    let `super`: Person
    
    let login: String
    let password: String
}

let user = User(super: Person(name: "John Appleseed"), login: "Johnny", password: "1234")

user.name // "John Appleseed"
user.login // "Johnny"
//print(user.super)


// Localization through String interpolation
extension String.StringInterpolation {
    mutating func appendInterpolation(localized key: String, _ args: CVarArg...) {
        let localized = String(format: NSLocalizedString(key, comment: ""), arguments: args)
        appendLiteral(localized)
    }
}


/*
 Let's assume that this is the content of our Localizable.strings:
 
 "welcome.screen.greetings" = "Hello %@!";
 */

let userName = "John"
print("\(localized: "welcome.screen.greetings", userName)") // Hello John!

//Property Wrappers as Debugging Tools
@propertyWrapper
struct History<Value> {
    private var value: Value
    private(set) var history: [Value] = []

    init(wrappedValue: Value) {
        self.value = wrappedValue
        print("init:\(value)")
    }
    
    var wrappedValue: Value {
        get { value }

        set {
            history.append(value)
            value = newValue
        }
    }
    
    var projectedValue: Self {
        return self
    }
}

// We can then decorate our business code
// with the `@History` wrapper
struct User1 {
    @History var name: String = ""
}

var user1 = User1()

// All the existing call sites will still
// compile, without the need for any change
user1.name = "John"
user1.name = "Jane"
user1.name = "Test"

// But now we can also access an history of
// all the previous values!
user1.$name.history // ["", "John"]
