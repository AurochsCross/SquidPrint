//
//  MultiWidgetContainer.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-12-02.
//

import SwiftUI
import SquidPrintLogic

struct MultiWidgetContainer<LeadingContent: View, TrailingContent: View>: View {
    enum Spacing {
        case equal
        case oneTwo
        
        var singlePartDivider: CGFloat {
            switch self {
            case .equal: return 2.0
            case .oneTwo: return 3.0
            }
        }
    }
    
    private let spacing: Spacing
    private let leadingContent: () -> LeadingContent
    private let trailingContent: () -> TrailingContent
    
    @State var width: CGFloat = 300.0
    
    private var leadingSizeMultiplyer: CGFloat {
        switch spacing {
        case .equal: return 0.5
        case .oneTwo: return 1.0 / 3.0
        }
    }
    
    private var trailingSizeMultiplyer: CGFloat {
        1.0 - leadingSizeMultiplyer
    }
    
    
    init(spacing: Spacing = .equal, @ViewBuilder leading: @escaping () -> LeadingContent, @ViewBuilder trailing: @escaping () -> TrailingContent) {
        self.spacing = spacing
        self.leadingContent = leading
        self.trailingContent = trailing
    }
    
    var body: some View {
        HStack {
            self.leadingContent()
                .frame(width: self.width * leadingSizeMultiplyer)
            self.trailingContent()
                .frame(maxWidth: .infinity)
        }
        .overlay(
            GeometryReader{ _ in
                EmptyView()
                    .onAppear { self.width = 500 }
            }
        )
    }
}

struct MultiWidgetContainer_Previews: PreviewProvider {
    static var previews: some View {
        MultiWidgetContainer(
            spacing: .oneTwo,
            leading: { HotEndAnimation(color: .black) },
            trailing: { VStack(alignment: .leading) {
                Text("Prolapsed time: ")
                Text("20h 19m")
            }.frame(maxWidth: .infinity, alignment: .leading) })
            .frame(width: 300, height: 100)
            .previewLayout(.sizeThatFits)
        
        DashboardView(viewModel: DashboardViewModel(serverManager: MockServerManager()))
    }
}
