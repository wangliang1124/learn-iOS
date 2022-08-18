import UIKit

let dogString = "Dog‼🐶"
let str: String? = ""
if let s = str {
    print("===",s)
}

print("===== unicodeScalars 码点 类似js的code point ====", dogString.count)
/* for(let ch of "Dog‼🐶")console.log(ch.codePointAt())  */
for ch in dogString.unicodeScalars {
    print(ch, String(ch).utf16.first ?? "")
//    for c in String(ch).utf16 {
//        print(ch.value, c)
//    }
}

print("===== utf16 代码单元 类似js的char code ====", dogString.utf16.count)
/* for(let ch of "Dog‼🐶")console.log(ch.charCodeAt()) */

for ch in dogString.utf16 {
    print(ch, type(of: ch))
}

print("===== utf8 代码单元  ====")

for ch in dogString.utf8 {
    print(ch)
}


let domain1 = "www.google.com"
var domain2 = "google.com"

let index1 = domain1.range(of: domain2, options: .backwards)


if let range = domain1.range(of: domain2, options: .backwards) {
    print(domain1[range] == domain2)
} else {
    print(false)
}

func isSubDomain(domain1: String, domain2: String) -> Bool {
    if domain1 == domain2 {
        return true
    }
    if let range = domain1.range(of: "." + domain2, options: .backwards) {
        return domain1[range] == "." + domain2
    } else  if let range = domain2.range(of: "." + domain1, options: .backwards) {
        return domain2[range] == "." + domain1
    }
    
    return false
}


print("isSubDomain===", isSubDomain(domain1: domain1, domain2: domain2))

let accounts = ["google.com", "liang@www.1google.com", "liang@www.google1.com", "liang@account.1google.com", "liang@google.com"]
domain2 = "google.com"

func getDomainBy(_ email: String) ->String? {
    let arr = email.split(separator: "@")
    print(arr)
    if let domain = arr.last {
        return String(domain)
    }
    return nil
}

let some = accounts.contains {
    if let domain2 = getDomainBy($0) {
        return isSubDomain(domain1: domain1, domain2: domain2)
    }
    return false
//    print("account",$0)
//    return isSubDomain(domain1: $0, domain2: domain2)
}

print("some===", some)
