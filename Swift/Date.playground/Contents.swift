import UIKit

var str = "Hello, playground"


Date.distantPast

print(Date.distantPast)
print(Date())

let dateFormatter = DateFormatter()
dateFormatter.dateFormat  = "h:mm a"
dateFormatter.string(from: Date())

print("------------------------------------")

let timeIntervals: [TimeInterval] = [
    60.0,
    100.0,
    600.0,
    10_450.0,
    100_844.0
]

let formatter = DateComponentsFormatter()
formatter.unitsStyle = .positional
formatter.allowedUnits = [.hour, .minute, .second]

for timeInterval in timeIntervals {
    print(formatter.string(from: timeInterval)!)
}

print("------------------------------------")

let timeInterval: TimeInterval = 25.0
let tmv = timeval(tv_sec: Int(timeInterval), tv_usec: 0)
Duration(tmv)
    .formatted(.time(pattern: .hourMinuteSecond))
Duration(tmv)
    .formatted(.time(pattern: .minuteSecond))

let duration: Duration = .seconds(3990)
duration.formatted(.time(pattern: .hourMinuteSecond))


func isCustomTime(date: Date) -> Bool {
    let hour1 = Calendar.current.component(.hour, from: date)
    let minutes = Calendar.current.component((.minute), from: date)
    print("hour1: \(hour1)")
    print("minutes: \(minutes)")
    
    let info = ["hour": 12, "pm": 1, "day": 1]
    
    if Calendar.current.isDateInToday(date) {
        print("today")
//        let info = SettingsManager.getScheduleOptionFor(.ScheduleLaterToday)
        if let hour = info["hour"], let pm = info["pm"] {
            var hour2 = hour
            if pm == 1 && hour < 12 {
                hour2 += 12
            }
            if pm == 0 && hour == 12 {
                hour2 = 0
            }
            
            return hour1 == hour2
        }
        
        return false
    }
    
    if false && Calendar.current.isDateInTomorrow(date) {
        print("tomorrow")
//        let info = SettingsManager.getScheduleOptionFor(.ScheduleTomorrow)
        if let hour = info["hour"], let pm = info["pm"] {
            var hour2 = hour
            if pm == 1 && hour < 12 {
                hour2 += 12
            }
            if pm == 0 && hour == 12 {
                hour2 = 0
            }
            
            return hour1 == hour2
        }
        
        return false
    } else {
        
//        let info = SettingsManager.getScheduleOptionFor(.ScheduleNextWeek)
        if let day2 = info["day"], var hour = info["hour"], let pm = info["pm"] {
            var hour2 = hour
            if pm == 1 && hour < 12 {
                hour2 += 12
            }
            if pm == 0 && hour == 12 {
                hour2 = 0
            }
            
            
            let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
            let components = (calendar as NSCalendar).components([.weekday], from: Date())
            if let weekday = components.weekday {
                let daysAway = (7 + day2 + 1 - weekday) % 7 + (weekday <= day2 ? 7 : 0)
                let nextDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * daysAway))
//                snoozeDate = (Calendar.current as NSCalendar).date(bySettingHour: hour, minute: 0, second: 0, of: nextDate, options: NSCalendar.Options(rawValue: 0))
                print("next week \(hour1), \(hour2)")
                return Calendar.current.isDate(date, inSameDayAs: nextDate) && hour1 == hour2
            }
            
           return false
        }
        
        
        
        
        
        return false
    }
}


if let date = Calendar.current.date(bySetting: .hour, value: 12, of: Date()) {
//    print(isCustomTime(date: date))
//    if let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: date) {
//        print(isCustomTime(date: tomorrow))
//    }
    if let nextWeek = Calendar.current.date(byAdding: .day, value: 7, to: date) {
        print(nextWeek)
        print(isCustomTime(date: nextWeek))
    }
}


 
