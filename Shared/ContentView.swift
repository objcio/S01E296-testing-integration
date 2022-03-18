//
//  ContentView.swift
//  Shared
//
//  Created by Chris Eidhof on 10.02.22.
//

import SwiftUI

struct ContentView: View {
    @State var model = Model()
    @State var date = Date.now
    @State var showDebug = false
    @State var online = true
    
    var day: Day { Day(date) }
   
    var body: some View {
        VStack(spacing: 20) {
            if online {
                SessionView(model: $model)
            }
            Text("Score \(model[day].totalScore)").font(.title)
            DatePicker(selection: $date, displayedComponents: .date, label: { Text("Date") })
                .labelsHidden()
                .datePickerStyle(.compact)
                .frame(width: 200)
            HStack(spacing: 20) {
                DayView(entries: $model[day].animation())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                if showDebug {
                    DebugView(model: model)
                        .frame(width: 200)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                        
                }
            }
        }
        .padding(20)
        .toolbar(content: {
            Group {
                Toggle("Debug Model", isOn: $showDebug.animation())
                    .fixedSize()
                Toggle("Online", isOn: $online)
                    .fixedSize()
            }
            #if os(macOS)
                .toggleStyle(.checkbox)
            #endif
        })
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
