import UIKit

func doWork(block: () -> Void) {
    block()
}

func doWorkAsync(block: @escaping () -> Void) {
    DispatchQueue.main.async {
        block()
    }
}

class S {
    var foo = "foo"
    func method1() {
        doWork {
            print(foo)
        }
        foo = "bar2222"
    }

    func method2() {
        doWorkAsync {
            print(self.foo)
        }
        foo = "bar1111"
    }
    
    func method3(){
        doWorkAsync {
            [weak self] in
            print(self?.foo ?? "nil???")
        }
    }
}

S().method1() // foo
S().method2() // bar
S().method3()


struct Vector2D {
   var x = 0.0
   var y = 0.0
}

func +(left: Vector2D, right: Vector2D) -> Vector2D {
   return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

let v1 = Vector2D(x: 2.0, y: 3.0)
let v2 = Vector2D(x: 1.0, y: 4.0)
let v3 = v1 + v2

func incrementor(variable: inout Int) {
   variable += 1
//   return variable
}

var luckyNumber = 7

incrementor(variable: &luckyNumber)

print(luckyNumber)
