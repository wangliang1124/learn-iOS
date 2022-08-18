//struct MarkStruct{
//   var mark1: Int
//   var mark2: Int
//   var mark3: Int
//}


struct studentMarks {
   var mark1 = 100
   var mark2 = 78
   var mark3 = 98
}

let marks = studentMarks()
print("Mark1 是 \(marks.mark1)")
print("Mark2 是 \(marks.mark2)")
print("Mark3 是 \(marks.mark3)")


struct MarksStruct {
   var mark: Int

   init(mark: Int) {
      self.mark = mark
   }
}
var aStruct = MarksStruct(mark: 98)
var bStruct = aStruct // aStruct 和 bStruct 是使用相同值的结构体！
bStruct.mark = 97
print(aStruct.mark) // 98
print(bStruct.mark) // 97


struct Number
{
    var digits: Int
    let numbers = 3.1415
}

var n = Number(digits: 12345)
n.digits = 67

print("\(n.digits)")
print("\(n.numbers)")
//n.numbers = 8.7 // error
