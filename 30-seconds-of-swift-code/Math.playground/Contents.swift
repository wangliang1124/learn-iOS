func factorial(num: Int) -> Int {
    var fact: Int = 1
    for index in stride(from: 1, to: num + 1, by: 1) {
        fact = fact * index
    }
    return fact
}

factorial(num: 4) //24
factorial(num: 10) //3628800

func average(arr: [Double]) -> Double {
    return arr.reduce(0, +) / Double(arr.count)
}

average(arr: [5, 4, 3, 2, 1]) //3

func gcd(num1: Int, num2: Int) -> Int {
    let mod = num1 % num2
    if mod != 0 {
        return gcd(num1: num2, num2: mod)
    }
    return num2
}

gcd(num1: 228, num2: 36) //12
gcd(num1: -5, num2: -10)
gcd(num1: 17, num2: 6)

func lcm1(num1: Int, num2: Int) -> Int {
    return abs(num1 * num2) / gcd(num1: num1, num2: num2)
}

lcm1(num1: 12, num2: 7) //84

func lcm2(arr1: [Int]) -> Int {
    return arr1.reduce(1, { lcm1(num1: $0, num2: $1) })
}

lcm2(arr1: [4, 3, 2]) //12

func minN(arr: [Int]) -> Int {
    var min =  arr[0]
    for num in arr {
        min = num < min ? num : min
    }
    return min
}

minN(arr: [8, 2, 4, 6]) //2
[8, 2, 4, 6].min() //2


func maxN(arr1: [Int]) -> Int {
    if let (_, maxValue) = arr1.enumerated().max(by: {$0.element < $1.element}) {
        return maxValue
    }
    
    return 0
}

maxN(arr1: [2, 9, 5]) //9
[2, 9, 5].max() //9

func calcBetterMedian(arr: [Int]) -> Float {
    let sorted = arr.sorted()
    if sorted.count % 2 == 0 {
        print(sorted.count / 2)
        return Float(sorted[sorted.count / 2] + sorted[sorted.count / 2 - 1]) / 2
    }

    return Float(sorted[(sorted.count - 1) / 2])
}

calcBetterMedian(arr: [1,2,3,4,5,6,7,8,9]) //returns 4.5

func calcMedian(arr: [Int]) -> Float {
    return Float(arr.sorted(by: <)[arr.count / 2])
}

calcMedian(arr: [1,2,3,4,5,6,7,8]) //returns 4.5


func radiansToDegrees(_ angle: Double) -> Double {
    return angle * 180 / .pi
}

radiansToDegrees(3.1415929) // 180

