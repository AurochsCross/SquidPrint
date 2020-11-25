//
//  TemperatureGraphWidget.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import SwiftUI
import Charts

struct TemperatureGraphWidget: View {
    var body: some View {
        VStack {
            HStack {
                HStack {
                    TemperatureIndicator(name: "Hotend", temperature: 205)
                        .foregroundColor(.orange)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                HStack {
                    TemperatureIndicator(name: "Bed", temperature: 64)
                        .foregroundColor(.blue)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            
            HStack {
                ZStack {
                    // Orange
                    
                
                    Chart(data: [0, 80, 130, 198, 213, 205, 205, 206, 202].map { Float($0) / 250 })
                        .chartStyle(LineChartStyle(.quadCurve, lineColor: .orange, lineWidth: 6))
                    Chart(data: [0, 205, 205, 205, 205, 205, 205, 205, 205].map { Float($0) / 250 })
                        .chartStyle(LineChartStyle(.quadCurve, lineColor: .orange, lineWidth: 6))
                        .opacity(0.3)
                    
                    // Blue
                    Chart(data: [0, 0, 0, 0, 0, 0, 10, 25, 49, 63, 60].map { Float($0) / 250 })
                        .chartStyle(LineChartStyle(.quadCurve, lineColor: .blue, lineWidth: 6))
                    
                    Chart(data: [0, 0, 0, 0, 0, 0, 60, 60, 60, 60, 60].map { Float($0) / 250 })
                        .chartStyle(LineChartStyle(.quadCurve, lineColor: .blue, lineWidth: 6))
                        .opacity(0.3)
                }
                Divider()
                VStack(alignment: .leading) {
                    Text("250°C")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("0°C")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxHeight: 300)
        }
    }
    
    private struct TemperatureIndicator: View {
        let name: String
        let temperature: Int
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(name.uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                    Text("\(temperature)")
                        .font(.title)
                        .bold() +
                    Text("°C")
                        .font(.headline)
                        .foregroundColor(.secondary)
            }
        }
    }
}

struct TemperatureGraphWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetPreviewer {
            TemperatureGraphWidget()
        }
    }
}
