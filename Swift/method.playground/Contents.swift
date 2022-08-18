class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func incrementBy(amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
// 初始计数值是0
let counter = Counter()

// 计数值现在是1
counter.increment()

// 计数值现在是6
counter.incrementBy(amount: 5)
print(counter.count)

// 计数值现在是0
counter.reset()
print(counter.count)


class Division {
    var count: Int = 0
    func incrementBy(first no1: Int, _ no2: Int) {
        count = no1 / no2
        print(count)
    }
}

let division = Division()
division.incrementBy(first: 1800, 3)
//division.incrementBy(first: 1600, no2: 5)
//division.incrementBy(first: 11000, no2: 3)


class calculations {
    let a: Int
    let b: Int
    let res: Int
    
    init(a: Int, b: Int) {
        self.a = a
        self.b = b
        res = a + b
        print("Self 内: \(res)")
    }
    
    func tot(c: Int) -> Int {
        return res - c
    }
    
    func result() {
        print("结果为: \(tot(c: 20))")
        print("结果为: \(tot(c: 50))")
    }
}

let pri = calculations(a: 600, b: 300)
//let sum = calculations(a: 1200, b: 300)

pri.result()
//sum.result()


struct area {
    var length = 1
    var breadth = 1
    
    func area() -> Int {
        return length * breadth
    }
    
    mutating func scaleBy(res: Int) {
        length *= res
        breadth *= res
        
//        print(length)
//        print(breadth)
        print(self)
    }
}

var val = area(length: 3, breadth: 5)
val.scaleBy(res: 3)
val.scaleBy(res: 30)
val.scaleBy(res: 300)
