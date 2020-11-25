//
//  MovementControlWidget.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import SwiftUI

struct MovementControlWidget: View {
    private let spacing: CGFloat = 10
    @State private var buttonSize: CGFloat = 60 // geometry.size.width / 5.0
    @State private var height: CGFloat = 300
    
    @State private var selectedStep = 0
    
    var body: some View {
        VStack(spacing: 20) {
            
            Picker("Hello", selection: $selectedStep) {
                Text("0.1mm").tag(0)
                Text("1mm").tag(1)
                Text("10mm").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            HStack {
                VStack(spacing: spacing) {
                    HStack(spacing: spacing) {
                        Spacer().frame(width: buttonSize)
                        MovementButton(icon: Image(systemName: "chevron.up"), size: buttonSize)
                        Spacer().frame(width: buttonSize)
                    }
                    HStack(spacing: spacing) {
                        MovementButton(icon: Image(systemName: "chevron.left"), size: buttonSize)
                        MovementButton(icon: Image(systemName: "house"), size: buttonSize)
                        MovementButton(icon: Image(systemName: "chevron.right"), size: buttonSize)
                    }
                    HStack(spacing: spacing) {
                        Spacer().frame(width: buttonSize)
                        MovementButton(icon: Image(systemName: "chevron.down"), size: buttonSize)
                        Spacer().frame(width: buttonSize)
                    }
                }
                Spacer()
                Divider()
                Spacer()
                VStack(spacing: spacing) {
                        MovementButton(icon: Image(systemName: "chevron.up"), size: buttonSize)
                        MovementButton(icon: Image(systemName: "house"), size: buttonSize)
                        MovementButton(icon: Image(systemName: "chevron.down"), size: buttonSize)
                }
            }
            .background( GeometryReader { geometry in
                EmptyView()
                    .onAppear {
                        log.info("Appeared")
                        self.buttonSize = geometry.size.width / 5.0
                    }
            })
            .frame(height: (buttonSize * 3) + (spacing * 2))
        }
        
    }
    
    private struct MovementButton: View {
        let icon: Image
        let size: CGFloat
        var body: some View {
            Button(action: { }) {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(width: size, height: size)
                    .background(Color.background)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct MovementControlWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetPreviewer { MovementControlWidget() }
//            .previewLayout(.device)
    }
}
