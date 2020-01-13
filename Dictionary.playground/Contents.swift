var dict:[String:String] = ["aa":"one","bbb":"two"]

print(dict["aa"]!)

var someDict:[Int:String] = [1:"One", 2:"Two", 3:"Three"]

//var someVar = someDict[1]

var oldVal = someDict.updateValue("One 新的值", forKey: 1)

print( "key = 1 的old值为 \(oldVal)" )
print( "key = 1 的值为 \(someDict[1])" )
print( "key = 2 的值为 \(someDict[2])" )
print( "key = 3 的值为 \(someDict[3])" )


//var someDict:[Int:String] = [1:"One", 2:"Two", 3:"Three"]

let dictKeys = [Int](someDict.keys)
let dictValues = [String](someDict.values)

print("输出字典的键(key)",dictKeys)

for (key) in dictKeys {
    print("\(key)")
}

print("输出字典的值(value)")

for (value) in dictValues {
    print("\(value)")
}
