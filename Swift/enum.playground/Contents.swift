import UIKit



// 定义枚举
enum DaysofaWeek {
    case Sunday
    case Monday
    case TUESDAY
    case WEDNESDAY
    case THURSDAY
    case FRIDAY
    case Saturday
}

var weekDay:DaysofaWeek = .Saturday
//weekDay = .FRIDAY
switch weekDay
{
case .Sunday:
    print("星期天")
case .Monday:
    print("星期一")
case .TUESDAY:
    print("星期二")
case .WEDNESDAY:
    print("星期三")
case .THURSDAY:
    print("星期四")
case .FRIDAY:
    print("星期五")
case .Saturday:
    print("星期六")
}

// 相关值
enum Student{
    case Name(String)
    case Mark(Int,Int,Int)
}

var studDetails = Student.Name("Runoob")
var studMarks = Student.Mark(98,97,95)

switch studMarks {
    case .Name(let studName):
        print("学生的名字是: \(studName)。")
    case .Mark(let Mark1, let Mark2, let Mark3):
        print("学生的成绩是: \(Mark1),\(Mark2),\(Mark3)。")
}

// 原始值
enum Month: Int {
    case January = 1, February, March, April, May, June, July, August, September, October, November, December
}

let yearMonth = Month.May.rawValue
print("数字月份为: \(yearMonth)。")
