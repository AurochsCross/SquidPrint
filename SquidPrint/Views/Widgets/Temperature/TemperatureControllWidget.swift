//
//  TemperatureControlls.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import SwiftUI

struct TemperatureControllWidget: View {
    @State private var isPressed = false
    @State private var offset: Int = Int.zero
    
    let title: String
    @Binding var currentTemperature: Int
    let maxTemperature: Int
    let color: Color
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title)
                    .bold()
                Spacer()
                Text("\(currentTemperature)")
                    .foregroundColor(color)
                    .font(.title)
                    .bold() +
                Text("°C")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color(.sRGB, white: 0.5, opacity: 0.2))
                
                GeometryReader { geometry in
                    Rectangle()
                        .foregroundColor(color)
                        .frame(width: geometry.size.width / CGFloat(maxTemperature) * CGFloat(currentTemperature + offset))
                        .animation(nil)
                }
                
                if isPressed {
                    Text("\(currentTemperature + offset)°C")
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged(self.onDragChanged)
                    .onEnded(self.onDragEnded)
            )
            .frame(height: 40)
            .cornerRadius(16)
            .animation(nil)
            .scaleEffect(isPressed ? 1.05 : 1.0)
            .shadow(radius: isPressed ? 10 : 0)
            .animation(Animation.linear(duration: 0.1))
        }
    }
    
    private func onDragChanged(_ gesture: DragGesture.Value) {
        self.isPressed = true
        var drag = Int(gesture.translation.width)
        
        drag = currentTemperature + drag < 0 ? -currentTemperature : drag
        drag = currentTemperature + drag > maxTemperature ? maxTemperature - currentTemperature : drag
        
        self.offset = drag
    }
    
    private func onDragEnded(_ gesture: DragGesture.Value) {
            self.isPressed = false
            self.currentTemperature += self.offset
            self.offset = 0
    }
}

struct TemperatureControllWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetPreviewer{ TemperatureControllWidget(title: "Hotend", currentTemperature: .constant(201), maxTemperature: 250, color: .green) }
    }
}
