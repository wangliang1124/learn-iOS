func runoob(site: String) -> String {
    return site
}

print(runoob(site: "www.runoob.com"))


func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print(bounds)
print("最小值为 \(bounds.min) ，最大值为 \(bounds.max)")



func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}


var x = 1
var y = 5
swapTwoInts(&x, &y)
print("x 现在的值 \(x), y 现在的值 \(y)")


func sum(a: Int, b: Int) -> Int {
    return a + b
}
var addition: (Int, Int) -> Int = sum
print("输出结果: \(addition(40, 89))")

func another(addition: (Int, Int) -> Int, a: Int, b: Int) {
    print("输出结果: \(addition(a, b))")
}
another(addition: sum, a: 10, b: 20)

/* 闭包 */
print("============闭包==============")
let divide = {(val1:Int,val2:Int)->Int in
    return val1/val2
}
let result = divide(200, 20)
print (result)

// 函数嵌套
func outerFunc() -> (()->()) {
    let outerScope = "outer scope"
    func innerFunc() {
        print(outerScope, "in inner func")
    }
    // 在外部函数内调用内部嵌套函数，在外部函数以外无法调用它
    return innerFunc
}
// 调用外部函数
outerFunc()()
 


let names = ["AT", "AE", "D", "S", "BE"]

// 使用普通函数(或内嵌函数)提供排序功能,闭包函数类型需为(String, String) -> Bool。
func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}
//var reversed = names.sorted(by: backwards)
var reversed = names.sorted(by:{$0>$1})
print(reversed)

//尾随闭包
var reversed1 = names.sorted() { $0 > $1 }
print(reversed1)


func makeIncrementor(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}

let incrementByTen = makeIncrementor(forIncrement: 10)

// 返回的值为10
print(incrementByTen())

// 返回的值为20
print(incrementByTen())

// 返回的值为30
print(incrementByTen())
