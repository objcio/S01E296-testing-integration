//
//  FoodCategory.swift
//  DietQualityScore
//
//  Created by Chris Eidhof on 10.02.22.
//

import Foundation

enum FoodCategory: String, CaseIterable, Codable, Hashable, Identifiable {
    case fruits = "Fruits"
    case vegetables = "Vegetables"
    case leanMeatsAndFish = "Lean Meats and Fish"
    case nutsAndSeeds = "Nuts and Seeds"
    case wholeGrains = "Whole Grains"
    case dairy = "Dairy"
    case refinedGrains = "Refined Grains"
    case sweets = "Sweets"
    case friedFoods = "Fried Foods"
    case fattyProteins = "Fatty Proteins"
    
    var id: Self { self }
    
    var emoji: String {
        switch self {
        case .fruits:
            return "🍊"
        case .vegetables:
            return "🥕"
        case .leanMeatsAndFish:
            return "🐟"
        case .nutsAndSeeds:
            return "🥜"
        case .wholeGrains:
            return "🌾"
        case .dairy:
            return "🥛"
        case .refinedGrains:
            return "🍜"
        case .sweets:
            return "🍭"
        case .friedFoods:
            return "🍟"
        case .fattyProteins:
            return "🥓"
        }
    }
}

extension FoodCategory {
    func totalScore(portions: Int) -> Int {
        return (0...portions).map {
            score(for: $0)
        }.reduce(0, +)
    }
    
    func score(for portion: Int) -> Int {
        guard portion > 0 else { return 0 }
        
        let s = self.scores()
        if portion < s.count { return s[portion-1] }
        return s.last!
    }
    
    private func scores() -> [Int] {
        switch self {
        case .fruits, .vegetables:
            return [2, 2, 2, 1, 0]
        case .leanMeatsAndFish, .nutsAndSeeds, .wholeGrains:
            return [2, 2, 1, 0, 0, -1]
        case .dairy:
            return [1, 1, 1 , 0, -1, -2]
        case .refinedGrains, .fattyProteins:
            return [-1, -1, -2]
        case .sweets, .friedFoods:
            return [-2]
        }
    }
}
