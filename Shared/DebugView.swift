import SwiftUI

fileprivate let formatter: DateFormatter = {
    var result = DateFormatter()
    result.dateStyle = .medium
    result.timeStyle = .none
    return result
}()

struct DebugView: View {
    var model: Model
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(model.entries.keys.sorted().reversed(), id: \.self) { day in
                    VStack(alignment: .leading, spacing: 0) {
                        Text(day.date, formatter: formatter).bold()
                            .padding(.bottom)
                        let entries: Entries = model.entries[day]!
                        ForEach(Array(entries.portions.keys.sorted(by: { $0.rawValue < $1.rawValue }))) { (category) in
                            HStack {
                                Text(category.rawValue)
                                Spacer()
                                Text("\(entries.portions[category]!.value)").monospacedDigit()
                            }
                        }
                    }
                    .transition(.opacity)
                }
                Color.clear.frame(height: 0) // Fixes a strange animation when the VStack is empty
            }
        }
    }
}
