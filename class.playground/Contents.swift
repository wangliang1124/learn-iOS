class student{
   var studname: String
//   var mark: Int
//   var mark2: Int
    init(name:String){
        self.studname = name
    }
}

let s =  student(name:"Test")
print(s.studname)

class studentMarks {
   var mark1 = 300
   var mark2 = 400
   var mark3 = 900
    var mark4=1_000
}
let marks = studentMarks()
print("Mark1 is \(marks.mark1)")
print("Mark2 is \(marks.mark2)")
print("Mark3 is \(marks.mark3)")
print("Mark3 is \(marks.mark4)")


class SampleClass: Equatable {
    let myProperty: String
    init(s: String) {
        myProperty = s
    }
}
func == <T:SampleClass>(lhs: T, rhs: T) -> Bool {
    return lhs.myProperty == rhs.myProperty
}

let spClass1 = SampleClass(s: "Hello")
let spClass2 = SampleClass(s: "Hello")

if spClass1 == spClass2 {// false
    print("引用相同的类实例 \(spClass1)")
}

//if spClass1 === spClass2 {// false
//    print("引用相同的类实例 \(spClass1)")
//}


if spClass1 !== spClass2 {// true
    print("引用不相同的类实例 \(spClass2)")
}
