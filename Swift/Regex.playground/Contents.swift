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


func replaceSrc(_ str:String) -> String {
    return str.replacingOccurrences(of: "\\s+src=", with: " edo-o-src=")
}


func makeTagsReStr(_ tags:[String]) -> String {
    let tags2 = tags.joined(separator: "|")

    let anyExceptChars = "[\\s\\S]*\\s+src="
    
    return "<\\s*(\(tags2))\(anyExceptChars)(>[\r|\n|\\s]*</\\1>|/?>)"
}


typealias TrackReplacerFunc = (String) -> String
typealias TestBeforeReplaceFunc = (String) -> Bool

// return a test function, which checked the string by an regexp of reStr
func reMatcher(_ reStr:String) -> TestBeforeReplaceFunc {
    return { (str:String) -> Bool in
        let m = matchPattern(str, pattern: reStr)
        return m.count != 0
    }
}

func matchPattern(_ target: String,
                  pattern: String,
                  options: NSRegularExpression.MatchingOptions = NSRegularExpression.MatchingOptions(rawValue: 0)) -> [NSTextCheckingResult] {
    do {
        let regexp = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.dotMatchesLineSeparators)
        return regexp.matches(in: target, options: options, range: target.fullNSRange())
    } catch {
         
        return []
    }
}

extension String {
    func fullNSRange() -> NSRange {
        let r = self.startIndex..<self.endIndex
        return NSRange(r, in: self)
    }
}


let digit0123 = "\\s*=\\s*['\"]?(?:(?:0*(?:1|2|3)\\D)|0+\\D)"
let invisibleReStr = "(?:display\\s*:['\"]?\\s*none)|(?:visibility\\s*:['\"]?\\s*hidden)"
let smallOrInvisible = reMatcher("(?:(?:\\s+width\(digit0123))|(?:\\s+height\(digit0123))|\(invisibleReStr))")

let regStr =  makeTagsReStr(["img", "font", "bgsound", "embed", "iframe", "frame"])

let regexp = try NSRegularExpression(pattern: regStr, options: NSRegularExpression.Options.dotMatchesLineSeparators)

let testStr = "<img  x=\"src=/>\" src=\"xxx\" />"

replaceSrc(testStr)

let repleceSrcReg = try NSRegularExpression(pattern: "\\s+src=", options: .caseInsensitive)
let range = NSMakeRange(0, testStr.count)
repleceSrcReg.stringByReplacingMatches(in: testStr, range: range, withTemplate: " edo-o-src=")
//let removeSimpleTagTracker = replaceBy(), replace: replaceSrc, test: smallOrInvisible)
//
//print(removeSimpleTagTracker)


