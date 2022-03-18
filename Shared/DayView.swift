import SwiftUI

struct DayView: View {
    @Binding var entries: Entries
    @State private var maxHeight: CGFloat? = nil
    
    var sortedCategories: [FoodCategory] {
        FoodCategory.allCases.sorted(by: { x, y in
            if entries.score(forPortion: x) > entries.score(forPortion: y) { return true }
            if entries.score(forPortion: x) < entries.score(forPortion: y) { return false }
            return x.rawValue < y.rawValue
        })
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(.adaptive(minimum: 180))]) {
                ForEach(FoodCategory.allCases.sorted(by: { entries.score(forPortion: $0) > entries.score(forPortion: $1)})) { category in
                    Button(action: {
                        entries.addPortion(category)
                    }, label: {
                        cell(for: category)
                    })
                }
            }
        }
        .buttonStyle(.plain)
        .withMaxHeight { maxHeight = $0}
    }
    
    func cell(for category: FoodCategory) -> some View {
        HStack(spacing: 0) {
            Text(category.emoji).font(.system(size: 40))
                .frame(width: 70)
            VStack(alignment: .leading) {
                Text(category.rawValue)
                    .bold()
                let delta = entries.score(forPortion: category)
                Text(delta > 0 ? "+\(delta)" : "\(delta)")
            }
            .padding(.trailing)
            Spacer()
        }
        .padding(.vertical)
        .measureMaxHeight()
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity)
        .frame(height: maxHeight)
        .background(RoundedRectangle(cornerRadius: 5).fill(.tertiary))
    }
}
