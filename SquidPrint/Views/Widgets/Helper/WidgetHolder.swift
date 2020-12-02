//
//  WidgetHolder.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import SwiftUI

struct WidgetHolder<Content: View>: View {
    var title: String?
    let content: () -> Content
    @Environment(\.colorScheme) var colorScheme
    
    init(title: String? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title = title {
                Text(title.uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            content()
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.sRGB, white: 0.5, opacity: 0.2))
                .cornerRadius(10)
        }
    }
}

struct WidgetHolder_Previews: PreviewProvider {
    static var previews: some View {
        WidgetHolder(title: "Widget") { TemperatureControllWidget(title: "Hotend", currentTemperature: .constant(nil), maxTemperature: 220, color: .green) }
    }
}
