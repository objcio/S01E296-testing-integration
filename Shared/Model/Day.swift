import Foundation

struct Day: Codable, Hashable, Comparable {
    var day, month, year: Int

    init(day: Int, month: Int, year: Int) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    init(_ date: Date) {
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: date)
        self = Day(day: comps.day!, month: comps.month!, year: comps.year!)
    }
    
    static func < (lhs: Day, rhs: Day) -> Bool {
        if lhs.year < rhs.year { return true }
        if lhs.year > rhs.year { return false }
        if lhs.month < rhs.month { return true }
        if lhs.month > rhs.month { return false }
        return lhs.day < rhs.day
    }
    
    var date: Date {
        Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
    }
}
