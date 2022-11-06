import Foundation

func mostFrequent<T: Hashable>(_ arr: [T]) -> T? {
    var dict = [T: Int]()
    for element in arr {
//        print(element)
        if dict[element] == nil {
            dict[element] = 1
        } else {
            dict[element]! += 1
        }
    }
//    print(dict)
    return dict.sorted(by: {$0.1 > $1.1}).first?.key
}

mostFrequent([1, 2, 5, 4, 1, 9, 8, 7, 4, 5, 1, 5, 1]) // 1
mostFrequent(["a", "b", "c", "a"]) // "a"
//mostFrequent([]) // nil

func commaSeparated(_ strings: [String]) -> String {
    return strings.joined(separator: ",")
}

let strs = ["Foo", "Bar", "Baz", "Qux"]
commaSeparated(strs) // "Foo, Bar, Baz, Qux"


func flatten<T>(arrays: [[T?]]) -> [T] {
    return arrays.flatMap {$0}.compactMap {$0}
}

flatten(arrays: [["a","b","c","d"],["e","f","g","y"]]) // ["a", "b", "c", "d", "e", "f", "g", "y"]
flatten(arrays: [[1,nil,3,4],[5,6,7,8]]) // [1, 3, 4, 5, 6, 7, 8]

func bubbleSort(_ input: [Int]) -> [Int] {
    guard input.count > 1 else {
        return input
    }
    
    var res = input
    let count = res.count
    var isSwapped = false
    
    repeat {
        isSwapped = false
        for index in stride(from: 1, to: count, by: 1) {
            if res[index] < res[index - 1] {
                res.swapAt(index - 1, index)
                isSwapped = true
            }
        }
        print(res)
    } while isSwapped
    
    return res
}

bubbleSort([32,12,12,23,11,19,81,76]) //[11, 12, 12, 19, 23, 32, 76, 81]


func chunk(arr: [Any], chunkSize: Int) -> [Any] {
    let chunks = stride(from: 0, to: arr.count, by: chunkSize).map {
        Array(arr[$0..<min($0 + chunkSize, arr.count)])
    }
    
    return chunks
}

chunk(arr: [2, 4, 6, 8], chunkSize: 1) //[[2], [4], [6], [8]]
chunk(arr: [1, 3, 5, 9], chunkSize: 4) //[[1, 3, 5, 9]]
chunk(arr: ["hi", "yo", "bye", "bai"], chunkSize: 3) //[["hi", "yo", "bye"], ["bai"]]
chunk(arr: ["young", "scrappy", "hungry"], chunkSize: 2) //[["young", "scrappy"], ["hungry"]]

//every_nth
func getEvery(nth: Int, from list: [Any]) -> [Any] {
    var nthElements = [Any]()
    
    var shiftedList = list
    shiftedList.insert(0, at: 0)
    
    for (i, ele) in shiftedList.enumerated() {
        if i > 0, i.isMultiple(of: nth) {
            nthElements.append(ele)
        }
    }
    
    return nthElements
}

getEvery(nth: 4, from: ["The", "quick", "brown", "fox", "jumped", "over", "the", "lazy", "dog"])  //["fox", "lazy"]

getEvery(nth: 2, from: [1,2,3,4,5,6,7,8,9]) //[2, 4, 6, 8]


func filterBools(_ input: [Any]) -> [Any] {
    return input.compactMap {$0 as? Bool} // filter {type(of: $0) == Bool.self}
}

filterBools([false, 2, "lol", 3, "a", "s", 34, false, true]) //[false, false, true]

func countOccurrences(arr: [String], into: String) -> Int {
    return arr.reduce(0) {$1 == into ? $0 + 1 : $0}
}

countOccurrences(arr: ["FOO", "FOO", "BAR"], into: "FOO") //2


func deepFlatten(arr: [AnyHashable]) -> [AnyHashable] {
    var arr2 = [AnyHashable]()
    for el in arr {
//        if let el = el as? Int {
//            arr2.append(el)
//        }
//
//        if let el = el as? [AnyHashable] {
//            let res = deepFlatten(arr: el)
//            for i in res {
//                arr2.append(i)
//            }
//        }
//
        if let el = el as? [AnyHashable] {
            let res = deepFlatten(arr: el)
            for i in res {
                arr2.append(i)
            }
        } else {
            arr2.append(el)
        }
        
        
    }
    
    return arr2
}

deepFlatten(arr: [6, 5, 4, [3, 2], [1]]) //[6, 5, 4, 3, 2, 1]
deepFlatten(arr: ["a", "5", "4", ["3", "2", "b"], ["c"]])
//print(["a", "5", "4", ["3", "2", "b"], ["c"]].compactMap { $0 })

func difference(arr1: [AnyHashable], arr2: [AnyHashable]) -> Set<AnyHashable> {
    return Set(arr1).symmetricDifference(arr2)
}

difference(arr1: [2, 4, 6, 8], arr2: [10, 8, 6, 4, 2, 0]) //0,10
difference(arr1: ["mulan", "moana", "belle", "elsa"], arr2: ["mulan", "moana", "belle", "pocahontas"]) //elsa, pocahontas


func duplicates(arr1: [AnyHashable]) -> Bool {
    return arr1.count != (Set<AnyHashable>(arr1).count)
}

duplicates(arr1: [5, 4, 3, 2]) //false
duplicates(arr1: ["hermione", "hermione", "ron", "harry"]) //true

func insertionSort(_ array: [Int]) -> [Int] {
    var arr = array
    
    for index in stride(from: 1, to: arr.count, by: 1) {
        var y = index
//        print(y)
        while y > 0 && arr[y] < arr[y - 1] {
            arr.swapAt(y - 1, y)
            y -= 1
        }
    }
    
    return arr
}

let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
insertionSort(list) //[-1, 0, 1, 2, 3, 3, 5, 8, 9, 10, 26, 27]

// https://developer.apple.com/documentation/swift/array/1688499-sort
var integerArray = [5,8,2,3,656,9,1]
var stringArray = ["India", "Norway", "France", "Canada", "Italy"]
integerArray.sort() //[1, 2, 3, 5, 8, 9, 656]
stringArray.sort() //["Canada", "France", "India", "Italy", "Norway"]


func shuffle(arr: [AnyHashable]) -> [AnyHashable] {
    var res = arr
    
    for i in stride(from: res.count - 1, through: 1, by: -1) {
        let j = Int.random(in: 0...i)
        if i != j {
            res.swapAt(i, j)
        }
    }
    
    return res
}

var foo = [1,2,3,4,5,6,7,8,9,10]
shuffle(arr: foo)
