//class Person {
//    var residence: Residence?
//}
//
//class Residence {
//    var numberOfRooms = 1
//}
//
//let john = Person()
//
//
////将导致运行时错误
////let roomCount = john.residence!.numberOfRooms
//
////print(roomCount)
//
//// 链接可选residence?属性，如果residence存在则取回numberOfRooms的值
//if let roomCount = john.residence?.numberOfRooms {
//    print("John 的房间号为 \(roomCount)。")
//} else {
//    print("不能查看房间号")
//}


class Person {
    var residence: Residence?
}

// 定义了一个变量 rooms，它被初始化为一个Room[]类型的空数组
class Residence {
    var rooms: [Room] = []
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        return rooms[i]
    }
    func printNumberOfRooms() {
        print("房间号为 \(numberOfRooms)")
    }
    var address: Address?
}

// Room 定义一个name属性和一个设定room名的初始化器
class Room {
    let name: String
    init(name: String) { self.name = name }
}

// 模型中的最终类叫做Address
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    init(buildingName:String, street:String){
        self.buildingName=buildingName
        self.street=street
    }
    
    func buildingIdentifier() -> String? {
        if (buildingName != nil) {
            return buildingName
        } else if (buildingNumber != nil) {
            return buildingNumber
        } else {
            return nil
        }
    }
}


//let john = Person()
//
//
//if ((john.residence?.printNumberOfRooms()) != nil) {
//    print("输出房间号")
//} else {
//    print("无法输出房间号")
//}


let john = Person()
let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "客厅"))
johnsHouse.rooms.append(Room(name: "厨房"))
john.residence = johnsHouse

let johnsAddress = Address(buildingName:"The Larches",street:"Laurel Street");
//johnsAddress.buildingName = "The Larches"
//johnsAddress.street = "Laurel Street"
john.residence!.address = johnsAddress

if let johnsStreet = john.residence?.address?.street {
    print("John 所在的街道是 \(johnsStreet)。")
} else {
    print("无法检索到地址。 ")
}


if let firstRoomName = john.residence?[0].name {
    print("第一个房间名为\(firstRoomName)")
} else {
    print("无法检索到房间")
}


var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0]+=1
testScores["Brian"]?[0] = 72
print(testScores)
