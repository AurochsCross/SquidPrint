//
//  MovementControlWidget.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import SwiftUI
import SquidPrintLogic

struct MovementControlWidget: View {
    private let spacing: CGFloat = 10
    @State private var buttonSize: CGFloat = 60
    @State private var height: CGFloat = 300
    
    @State private var selectedStep = 1
    private var stepSize: Double {
        switch selectedStep {
        case 0: return 0.1
        case 1: return 1
        case 2: return 10
        case 3: return 100
        default: return 0
        }
    }
    
    var onMove: ((PrintheadInstructionSet) -> ())? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            
            Picker("Hello", selection: $selectedStep) {
                Text("0.1mm").tag(0)
                Text("1mm").tag(1)
                Text("10mm").tag(2)
                Text("100mm").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            HStack {
                VStack(spacing: spacing) {
                    HStack(spacing: spacing) {
                        Spacer().frame(width: buttonSize)
                        MovementButton(icon: Image(systemName: "chevron.up"), size: buttonSize, action: { self.move(.y) })
                        Spacer().frame(width: buttonSize)
                    }
                    HStack(spacing: spacing) {
                        MovementButton(icon: Image(systemName: "chevron.left"), size: buttonSize, action: { self.move(.x, reverse: true) })
                        MovementButton(icon: Image(systemName: "house"), size: buttonSize, action: { self.onMove?(PrintheadHomingInstructions(homingAxis: .xy)) })
                        MovementButton(icon: Image(systemName: "chevron.right"), size: buttonSize, action: { self.move(.x) })
                    }
                    HStack(spacing: spacing) {
                        Spacer().frame(width: buttonSize)
                        MovementButton(icon: Image(systemName: "chevron.down"), size: buttonSize, action: { self.move(.y, reverse: true) })
                        Spacer().frame(width: buttonSize)
                    }
                }
                Spacer()
                Divider()
                Spacer()
                VStack(spacing: spacing) {
                    MovementButton(icon: Image(systemName: "chevron.up"), size: buttonSize, action: { self.move(.z) })
                    MovementButton(icon: Image(systemName: "house"), size: buttonSize, action: { self.onMove?(PrintheadHomingInstructions(homingAxis: .z)) })
                    MovementButton(icon: Image(systemName: "chevron.down"), size: buttonSize, action: { self.move(.z, reverse: true) })
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
    
    
    
    private func move(_ axis: MoveAxis, reverse: Bool = false) {
        self.onMove?(PrintheadMoveInstructions(axis: axis, step: self.stepSize * (reverse ? -1 : 1)))
    }
    
    private struct MovementButton: View {
        let icon: Image
        let size: CGFloat
        
        let action: () -> ()
        
        var body: some View {
            Button(action: action) {
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
    }
}
