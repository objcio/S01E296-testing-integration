//
//  MaxHeight.swift
//  SharedTests
//
//  Created by Chris Eidhof on 10.02.22.
//

import Foundation
import SwiftUI

struct MaxHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

extension View {
    func measureMaxHeight() -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: MaxHeightKey.self, value: proxy.size.height)
        })
    }
    
    func withMaxHeight(_ perform: @escaping (CGFloat) -> ()) -> some View {
        onPreferenceChange(MaxHeightKey.self) { perform($0) }
    }
}
