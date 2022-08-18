import UIKit

var str = "Hello, playground"


var someArray = [Int](repeating:1,count:5)

print(someArray,"count=\(someArray.count)")


var someInts:[Int] = [10, 20, 30]

someInts.append(40)
someInts+=[50]

someInts = someArray + someInts

for i in someInts {
    print(i)
}

var someStrs = [String]()

someStrs.append("Apple")
someStrs.append("Amazon")
someStrs.append("Runoob")
someStrs += ["Google"]

for (index,item) in someStrs.enumerated(){
    print(index,item)
}


var lookup = ["string":3]
print(lookup)
