//
//  HotEndAnimation.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-24.
//

import SwiftUI
import SquidPrintLogic

struct HotEndAnimation: View {
    let color: Color
    
    private let width: CGFloat = 40
    private let height: CGFloat = 5
    
    @State var animateFillament = false
    
    var body: some View {
        ZStack {
            Image("Asset-Hotend")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
                .frame(width: 130)
                .foregroundColor(color)
            Rectangle()
                .fill(Color.clear)
                .frame(width: width, height: height)
                .overlay(
                    HStack {
                        Rectangle()
                            .frame(width: width)
                            .cornerRadius(height / 2)
                        Spacer()
                            .frame(width: height / 2)
                        Rectangle()
                            .frame(width: width)
                            .cornerRadius(height / 2)
                        Spacer()
                            .frame(width: height / 2)
                        Rectangle()
                            .frame(width: width)
                            .cornerRadius(height / 2)
                    }
                    .foregroundColor(color)
                    .offset(x: (animateFillament ? 0 : width + height / 2))
                    .animation(Animation.linear(duration: 3).repeatForever(autoreverses: false))
                )
                .cornerRadius(height / 2)
                .offset(x: -width / 2 + height / 2, y: 37)
        }
        .onAppear{
            self.animateFillament.toggle()
        }
    }
}

struct HotEndAnimation_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: DashboardViewModel(serverManager: MockServerManager()))
//        HotEndAnimation(color: .green)
//            .padding()
//            .previewLayout(.sizeThatFits)
    }
}
