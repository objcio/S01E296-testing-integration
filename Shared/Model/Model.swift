import Foundation
import CRDTs

struct Entries: Codable, Mergable, Equatable {
    var portions: [FoodCategory: GCounter<Int>] = [:]
    
    var totalScore: Int {
        portions.map { (key, value) in
            key.totalScore(portions: value.value)
        }.reduce(0, +)
    }
    
    func score(forPortion category: FoodCategory) -> Int {
        category.score(for: portions[category, default: GCounter(0)].value + 1)
    }
    
    mutating func addPortion(_ category: FoodCategory) {
        portions[category, default: GCounter(0)] += 1
    }
    
    mutating func merge(_ other: Entries) {
        portions.merge(other.portions)
    }
}

struct Model: Codable, Mergable, Equatable {
    var entries: [Day: Entries] = [:]
    
    subscript(day: Day) -> Entries {
        get {
            entries[day, default: .init()]
        }
        set {
            entries[day] = newValue
        }
    }
    
    mutating func merge(_ other: Model) {
        entries.merge(other.entries)
    }
}
