struct Rectangle {
    var length: Double
    var breadth: Double
    var area: Double
    
    init(fromLength length: Double, fromBreadth breadth: Double) {
        self.length = length
        self.breadth = breadth
        area = length * breadth
    }
    
    init(fromLen len: Double, fromBread bread: Double) {
        self.length = len
        self.breadth = bread
        area = len * bread
    }
}

let ar = Rectangle(fromLength: 6, fromBreadth: 12)
print("面积为: \(ar.area)")

let are = Rectangle(fromLen: 36.0, fromBread: 12)
print("面积为: \(are.area)")


struct Size {
    var width = 0.0
    var height = 0.0
}
struct Point {
    var x = 0.0
    var y = 0.0;
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}


// origin和size属性都使用定义时的默认值Point(x: 0.0, y: 0.0)和Size(width: 0.0, height: 0.0)：
let basicRect = Rect()
print("Size 结构体初始值: \(basicRect.size)")
print("Rect 结构体初始值: \(basicRect.origin) ")

// 将origin和size的参数值赋给对应的存储型属性
let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))

print("Size 结构体初始值: \(originRect.size) ")
print("Rect 结构体初始值: \(originRect.origin) ")


//先通过center和size的值计算出origin的坐标。
//然后再调用（或代理给）init(origin:size:)构造器来将新的origin和size值赋值到对应的属性中
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
    size: Size(width: 3.0, height: 3.0))

print("Size 结构体初始值: \(centerRect.size) ")
print("Rect 结构体初始值: \(centerRect.origin) ")


class Cat {
    var name: String
    init() {
        name = "cat"
    }
}

class Tiger: Cat {
    let power: Int
    override init() {
        power = 10
            super.init()
        self.name = "tiger"
    
        
    }
}

var tiger = Tiger()
print(tiger.name)
