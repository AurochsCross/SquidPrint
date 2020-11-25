//
//  TemperatureView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import SwiftUI

struct TemperatureView: View {
    @State var hotendTemperature: Int = 20
    @State var bedTemperature: Int = 5
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 40) {
                    TemperatureGraphWidget()
                        .frame(height: 200)
                        .padding(.horizontal)
                    VStack {
                        WidgetHolder(title: "Temperature Controlls") {
                            TemperatureControllWidget(title: "Hotend", currentTemperature: $hotendTemperature, maxTemperature: 250, color: .orange)
                        }
                        WidgetHolder {
                            TemperatureControllWidget(title: "Bed", currentTemperature: $bedTemperature, maxTemperature: 100, color: .blue)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle(Text("Temperature"))
        }
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView()
            .preferredColorScheme(.dark)
    }
}
