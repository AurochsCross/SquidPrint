//
//  WidgetPreviewer.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import SwiftUI

struct WidgetPreviewer<Content: View>: View {
    let content: () -> Content
    @Environment(\.colorScheme) var colorScheme
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.sRGB, white: 0.5, opacity: 0.2))
            .cornerRadius(10)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

struct WidgetPreviewer_Previews: PreviewProvider {
    static var previews: some View {
        WidgetPreviewer(content: { Text("Hello") })
    }
}
