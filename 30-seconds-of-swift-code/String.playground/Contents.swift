import Foundation
// String
func bytes(_ str: String) -> Int {
    return str.utf8.count
}

bytes("hello")

func capitalizeFirst(str: String) -> String {
    var firstLetter = str.prefix(1).uppercased()
    
     
    
    return firstLetter + str.dropFirst().lowercased()
}

capitalizeFirst(str: "i like cheesE") //I like cheesE


func capitalizeEveryWord(str: String) -> String {
    return str.capitalized
}

capitalizeEveryWord(str: "on a scale from 1 to 10 how would you rate your pain") //On A Scale From...
capitalizeEveryWord(str: "well, hello there!") //Well, Hello There!


func countVowels(str: String) -> Int {
    var vowelCount = 0
    let vowels = Set(["a", "e", "i", "o", "u"])
    for char in str.lowercased() {
        if vowels.contains("\(char)") {
            vowelCount += 1
        }
    }
    
    return vowelCount
}

countVowels(str: "hi mom") //2
countVowels(str: "aeiou") //5


func lowercaseFirstLetterOfFirstWord(str: String) -> String {
    var components = str.components(separatedBy: " ")

    components[0] = components[0].lowercased()
    return components.joined(separator: " ")
}

lowercaseFirstLetterOfFirstWord(str: "Christmas Switch wAs a solid movie")
"Christmas Switch wAs a solid movie".lowercased()

func isLowercase(str: String) -> Bool {
    return str == str.lowercased()
}

isLowercase(str: "I LOVE CHRISTMAS") //false
isLowercase(str: "<3 lol") //true

func isUppercase(str: String) -> Bool {
    return str.uppercased() == str
}

isUppercase(str: "LOLOLOL") //true
isUppercase(str: "lmao") //false
isUppercase(str: "Rofl") //false

func palindrome(str: String) -> Bool {
    return str.lowercased() == String(str.reversed()).lowercased()
}

palindrome(str: "racecar") //true
palindrome(str: "Madam") //true
palindrome(str: "lizzie") //false

func anagram(_ str1: String, _ str2: String) -> Bool {
    let s1 = str1.filter {!$0.isWhitespace}.lowercased()
    let s2 = str2.filter {!$0.isWhitespace}.lowercased()
    
    return s1.count == s2.count && s1.sorted() == s2.sorted()
}

anagram("abcd3", "3acdb") // true
anagram("123", "456") // false
anagram("Buckethead", "Death Cube K") // true


func drop(arr: [AnyHashable], num: Int) -> [AnyHashable] {
    return Array(arr.dropFirst(num))
}

drop(arr: [5, 4, 3, 2, 1, 0], num: 1)
drop(arr: ["Huey", "Dewey", "Louie"], num: 3)

func arrayToCSV(_ input: [[String]]) -> String {
    var csv = ""
    for row in input {
        csv.append(row.map {"\"\($0)\""}.joined(separator: ", ") + "\n")
    }
    
    return csv
}

arrayToCSV([["a", "b", "c"], ["d", "e", "f"], ["g", "h", "i"]])

func flip<A, B, C>(_ function: @escaping ((A, B) -> C)) -> ((B, A)->C) {
    return { a,b in
        return function(b, a)
    }
}

// flip example 1
func concat(_ alpha: String, _ beta: String) -> String {
    return alpha + beta
}

let reverseConcat = flip(concat)
concat("A", "B") //"AB"
reverseConcat("A", "B") //"BA"

// flip example 2
func gt(_ a: Int, _ b: Int) -> Bool {
    return a > b
}

let lt = flip(gt)

gt(5, 3) //true
lt(5, 3) //false
gt(2, 5) //false
lt(2, 5) //true

func dropRight(arr: [Int], while predicate: (Int) -> Bool) -> [Int] {
    var returnArr = arr
    for item in arr.reversed() {
        if predicate(item) { break }
        returnArr = returnArr.dropLast()
    }
    return returnArr
}

print(dropRight(arr: [1, 2, 3, 4, 5], while: { $0 < 0 })) //[]
print(dropRight(arr: [1, 2, 3, 4, 5], while: { $0 > 0 })) //[1, 2, 3, 4, 5]

func filterNonUnique(arr: [Any]) -> [Any] {
    return NSOrderedSet(array: arr).array
}

filterNonUnique(arr: [1, 2, 2, 3, 5]) // [1, 2, 3, 5]
filterNonUnique(arr: ["Tim", "Steve", "Tim", "Jony", "Phil"]) // ["Tim", "Steve", "Jony", "Phil"]


func snake(str: String) -> String? {
    let pattern = "([a-z0-9])([A-Z])"
    let regex = try?NSRegularExpression(pattern: pattern, options: [])
    let range = NSRange(location: 0, length: str.count)
    return regex?.stringByReplacingMatches(in: str, options: [], range: range, withTemplate: "$1_$2")
        .lowercased()
        .replacingOccurrences(of: " ", with: "_")
        .replacingOccurrences(of: "-", with: "_")
}

snake(str: "camelCase") // 'camel_case'
snake(str: "some text") // 'some_text'
snake(str: "some-mixed_string With spaces_underscores-and-hyphens") // 'some_mixed_string_with_spaces_underscores_and_hyphens'
snake(str: "AllThe-small Things") // "all_the_smal_things"

func snakeCase(_ text: String) -> String {
    let arrOfStrings = text.components(separatedBy: " ")
    return arrOfStrings.joined(separator: "_").lowercased()
}

let text = "Snake case is the practice of writing compound words or phrases in which the elements are separated with one underscore character and no spaces."
snakeCase(text)

func firstUniqueCharacter(_ str: String) -> Character? {
    var countDict: [Character: Int] = [:]
    for char in str {
        countDict[char] = (countDict[char] ?? 0) + 1
    }
    
    return str.filter {countDict[$0] == 1}.first
}

firstUniqueCharacter("barbeque nation") //"r"

// Prints a string N times without using loops.
func repeating(_ repeatedValue: String, count: Int) {
    guard count > 0 else { return }
    
    print(repeatedValue)
    repeating(repeatedValue, count: count - 1)
}

repeating("Hello", count: 5)


func stringLengthInBytes(_ string: String) -> Int {
    return (string as NSString).length
}

stringLengthInBytes("hellǑ")
 

func everyNth(list: [Any], n: Int) -> [Any] {
    return list.enumerated().compactMap { ($0.offset + 1) % n == 0 ? $0.element : nil }
}

everyNth(list: [1, 2, 3, 4, 5, 6], n: 2) // [ 2, 4, 6 ]
everyNth(list: ["a", "b", "c", "d", "e", "f"], n: 3) // [ "c", "f" ]


func isSorted(arr: [Int]) -> Int {
    var asc: Bool = true
    var prev: Int = Int.min
    for elem in arr {
        if elem < prev {
            asc = false
            break
        }
        prev = elem
    }
    if asc {
        return 1
    }
    
    var dsc: Bool = true
    prev = Int.max
    for elem in arr {
        if elem > prev {
            dsc = false
            break
        }
        prev = elem
    }
    if dsc {
        return -1
    }
    
    return 0
}

isSorted(arr: [1, 2, 2, 4, 8]) // 1
isSorted(arr: [8, 4, 4, 2, 1]) // -1
isSorted(arr: [1, 4, 2, 8, 4]) // 0


func sortedArray(arr: [Int]) -> Int {
    let sortedArr = arr.sorted(by: <)
    return arr == sortedArr ? 1 : arr == sortedArr.reversed() ? -1 : 0
}

sortedArray(arr: [1,2,3,4,5])
sortedArray(arr: [5,4,3,2,1])
sortedArray(arr: [6,2,3,4,8])


func camelCaseToSnake(str: String) -> String {
    guard let regex = try? NSRegularExpression(pattern: "([a-z0-9])([A-Z])", options: []) else {
        return str
    }
    
    let range = NSRange(location: 0, length: str.count)
    
    return regex.stringByReplacingMatches(in: str, range: range, withTemplate: "$1_$2").lowercased()
}

camelCaseToSnake(str: "appleIphoneX")
camelCaseToSnake(str: "camelCaseStringToSnakeCase")
camelCaseToSnake(str: "string")
camelCaseToSnake(str: String())
camelCaseToSnake(str: "firstPullRequestForHacktoberFest🍁☔️🤖")



