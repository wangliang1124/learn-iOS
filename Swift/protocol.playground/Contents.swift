protocol classa {
    
    var marks: Int { get set }
    var result: Bool { get }
    
    func attendance() -> String
    func markssecured() -> String
    
}

protocol classb: classa {
    
    var present: Bool { get set }
    var subject: String { get set }
    var stname: String { get set }
    
}

class classc: classb {
    var marks = 96
    let result = true
    var present = false
    var subject = "Swift 协议"
    var stname = "Protocols"
    
    func attendance() -> String {
        return "The \(stname) has secured 99% attendance"
    }
    
    func markssecured() -> String {
        return "\(stname) has scored \(marks)"
    }
}

let studdet = classc()
studdet.stname = "Swift"
studdet.marks = 98
studdet.markssecured()

print(studdet.marks)
print(studdet.result)
print(studdet.present)
print(studdet.subject)
print(studdet.stname)


