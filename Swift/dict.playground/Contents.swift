import UIKit

var str = "Hello, playground"

var result = [
    ["a": false],
    ["b": true],
    ["c": false],
]

print(result.joined())

//var res1 = result.reduce(true) { res, keyValue in
//    let v
//    for (_, value) in keyValue {
//       v =  value
//    }
//    return res && value
//}
//print(res1)

//let letters = "abracadabra"
//let letterCount = letters.reduce(into: [:]) { counts, letter in
//    counts[letter, default: 0] += 1
//}
//print(letterCount)
