// Object
func allUnique(arr: [AnyHashable]) -> Bool {
    return arr.count == Set<AnyHashable>(arr).count
}

allUnique(arr: [5, 4, 3, 2]) //true
allUnique(arr: ["lol", "rofl", "lol"]) //false

func justKeys(dict: [AnyHashable: AnyHashable]) -> [AnyHashable] {
    return Array(dict.keys)
}

var dict: Dictionary<String, String> = ["Mulan": "Mushu", "Anna": "Olaf", "Pocahontas": "Fleeko"]
justKeys(dict: dict) //[Anna, Mulan, Pocahontas]

func justValues(dict: [AnyHashable: AnyHashable]) -> [AnyHashable] {
    return Array(dict.values)
}

justValues(dict: dict) //[Olaf, Mushu, Fleeko]

