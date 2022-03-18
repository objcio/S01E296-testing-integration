import Foundation
import XCTest
@testable import DietQualityScore

final class FoodCategoryTests: XCTestCase {
    func testSimple() {
        XCTAssertEqual(FoodCategory.fruits.score(for: 0), 0)
        XCTAssertEqual(FoodCategory.fruits.score(for: 1), 2)
        XCTAssertEqual(FoodCategory.fruits.score(for: 2), 2)
        XCTAssertEqual(FoodCategory.fruits.totalScore(portions: 3), 6)
        XCTAssertEqual(FoodCategory.sweets.totalScore(portions: 3), -6)
        XCTAssertEqual(FoodCategory.sweets.totalScore(portions: 10), -20)
    }
}
