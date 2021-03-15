import UIKit

var str = "Hello, playground"

func filterSpecialSenderName(_ email: String) -> Bool {
    let pattern = ".*no.*reply.*@.+" // e.g. no-replay@google.com
    
    guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: pattern, options: [NSRegularExpression.Options.caseInsensitive]) else {
        return false
    }
    
    let matches = regex.matches(in: email, options: [], range:NSRange(location: 0, length: email.count))
    
    if let _ = matches.first {
        return true
    }
    return false
}

filterSpecialSenderName("no+rseply@ab.com.cn.org")

