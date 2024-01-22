import UIKit



var arr = ["aaa", "bbb"]
var str = arr.joined(separator: ",")
print(str)


Date.now
Date.distantPast



// 溢出运算符
var num: UInt8 = 255
var result12 = num &+ 1 // 溢出后变为0
result12 = result12 &- 1 // 溢出后再减1，255
result12 = result12 &* 2 // 即 0b11111111 << 1 = 0b11111110 = 254

 
var willUnderflow = UInt8.min
// willUnderflow 等于UInt8的最小值0
willUnderflow = willUnderflow &- 1
// 此时 willUnderflow 等于 255

var signedUnderflow = Int8.min
// signedUnderflow 等于最小的有符整数 -128
signedUnderflow = signedUnderflow &- 1
// 如今 signedUnderflow 等于 127


// 重载运算符 + , 元组相加，扩展加号的新功能
func +(param1: (Int, Int), param2: (Int, Int)) -> (Int, Int) {
    return (param1.0 + param2.0, param1.1 + param2.1)
}
var tuple1: (Int, Int) = (1, 2)
var tuple2: (Int, Int) = (1, 2)
let tuple = tuple1 + tuple2 // (2, 4)

 

// 自定义运算符
// 自定义前缀运算符，即只需要一个操作数，运算符在操作数前面
prefix operator ++
prefix func ++(param: Int) -> Int {
    return param + 1
}
++1 // 2

// 自定义中缀运算符，即需要两个操作数，运算符在两个操作数中间
infix operator **
func **(param1: Int, param2: Int) -> Int {
    return param1 * param1 + param2 * param2
}
1 ** 2 // 5

// 自定义后缀运算符，即只需要一个操作数，运算符在操作数后面
postfix operator --
postfix func --(param: Int) -> Int {
    return param - 1
}
3--
++0 ** 3-- // 5
 

class Base {}

//var closure = {(param: Int) -> Int in return param}
//
//// Swift 使用 Any 类型声明数组，其中可以存放任何类型，包含 值类型 和 引用类型
//var arrayAny: [AnyObject] = [ Base(),  closure]
 

// 1. Swift inout 参数读写冲突
var inputStr = "input"
func plusSlef1(_ param: inout String) {
    // 在 >= Swift4 版本会抛异常：同时访问0x103ed30a0，但是修改需要独占访问。
    param += inputStr
}
// 调用下面的代码会崩溃
// plusSlef1(&inputStr)

// 同时访问同一个内存地址，造成读写冲突
func plusSlef2(_ param1: inout String, _ param2: inout String) {
    // 在 >= Swift4 版本会抛异常：重叠访问'inputStr'，但修改需要独占访问；考虑复制到一个局部变量
    let result = param1;// + param2
    print(result)
}
// 调用下面的代码会崩溃
// plusSlef2(&inputStr, &inputStr)


// 使用界定符时，转义符失去作用
var text4 = #"换行符1 \n 换行符2"#
print(text4) // 换行符1 \n 换行符2

// 使用界定符时，使用 \# 保留转义符的作用
var text5 = #"换行符1 \#n 换行符2"#
print(text5) // 会换行打印: 换行符1 换行符2

 
@dynamicMemberLookup // Swift使用 @dynamicMemberLookup 为类增加动态查找成员的能力
@dynamicCallable // Swift使用 @dynamicCallable 为类增加动态方法调用的能力
class Data {
    var field1: Int = 0
    var field2: String = ""
    
    subscript(dynamicMember member: Int) -> String {
        return "class don't have the field: \(member), type int"
    }
    
    subscript(dynamicMember member: String) -> String {
        return "class don't have the field: \(member), type String"
    }
    
    // 传入一组参数
    func dynamicallyCall(withArguments argArray: [Int]) {
        print("invoke unknown func with args: \(argArray)")
    }
    
    // 传入键值对参数
    func dynamicallyCall(withKeywordArguments pairs: KeyValuePairs<String, Int>) {
        let argPairs = pairs.map{ key, value in
            return "\(key): \(value)"
        }
        print(argPairs)
    }
}

let data = Data()
// 当访问不存在的属性时，就会调用对应的 subscript 方法返回对应类型的值
// class don't have the field: someInt, type String. class don't have the field: someString, type String
print(data.someInt, data.someString)


// 调用不存在的方法，把实例当做方法调用
// 传入一组参数
data(1, 2, 3) // invoke unknown func with args: [1, 2, 3]
// 传入键值对参数
data(key1: 1, key2: 2) // ["key1: 1", "key2: 2"]
 
