// Swift5 属性监听器
class iOS {
     
    var brand: String {
        // 此属性将要被赋值时会调用，默认带一个 newValue 字段。
        // 注意：初始化时不会被调用，从第二次赋值时才开始被调用
        willSet {
            print("new value : \(newValue)")
        }
        // 此属性已经被赋值后会调用，默认带一个 oldValue 字段
        didSet {
            print("old value : \(oldValue)")
        }
    }
    
    var price: Int {
        // 自定义传值名称
        willSet(newPrice) {
            print("new price : \(newPrice)")
        }
        // 自定义传值名称
        didSet(oldPrice) {
            print("old price : \(oldPrice)")
        }
    }
        
    init(brand: String, price: Int) {
        self.brand = brand
        self.price = price
        print("brand: \(brand), price: \(price)")
    }
}

let newIPhone = iOS(brand: "iphone 12", price: 5999)
newIPhone.brand = "iphone 13"
newIPhone.price = 6999

 
