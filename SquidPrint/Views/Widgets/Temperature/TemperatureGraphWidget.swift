//
//  TemperatureGraphWidget.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import SwiftUI
import Charts
import OpenAPIClient
import SquidPrintLogic

struct TemperatureGraphWidget: View {
    let temperatures: [TemperatureFrame]
    
    private var maxTemperature: Double {
        if temperatures.count == 0 { return 100 }
        
        return temperatures.map { frame -> Double in
            [frame.bed.actual!, frame.bed.target!, frame.hotend.actual!, frame.hotend.target!].max()!
        }
        .max()!
    }
    
    private var bedTemperature: Double {
        temperatures.last?.bed.actual ?? 0
    }
    
    private var hotendTemperature: Double {
        temperatures.last?.hotend.actual ?? 0
    }
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    TemperatureIndicator(name: "Hotend", temperature: Int(hotendTemperature))
                        .foregroundColor(.orange)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                HStack {
                    TemperatureIndicator(name: "Bed", temperature: Int(bedTemperature))
                        .foregroundColor(.blue)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            
            HStack {
                ZStack {
                    TemperatureLine(temperatures: temperatures.map { $0.hotend }, maxTemperature: maxTemperature, color: .orange)
                        .animation(.default)
                    TemperatureLine(temperatures: temperatures.map { $0.bed }, maxTemperature: maxTemperature, color: .blue)
                }
                .padding(.vertical, 3)
                .clipped()
                Divider()
                VStack(alignment: .leading) {
                    Text("\(Int(maxTemperature))°C")
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
    
    private struct TemperatureLine: View {
        let temperatures: [Temperature]
        let maxTemperature: Double
        let color: Color
        
        var body: some View {
            Chart(data: temperatures.map { Double($0.actual!) / maxTemperature })
                .chartStyle(LineChartStyle(.line, lineColor: color, lineWidth: 6))
            Chart(data: temperatures.map { Double($0.target!) / maxTemperature })
                .chartStyle(LineChartStyle(.line, lineColor: color, lineWidth: 6))
                .opacity(0.3)
        }
    }
}

struct TemperatureGraphWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        let temperatures = [
            TemperatureFrame(bed: Temperature(actual: 0, target: 0), hotend: Temperature(actual: 0, target: 0)),
            TemperatureFrame(bed: Temperature(actual: 50, target: 200), hotend: Temperature(actual: 0, target: 0)),
            TemperatureFrame(bed: Temperature(actual: 100, target: 200), hotend: Temperature(actual: 0, target: 100)),
            TemperatureFrame(bed: Temperature(actual: 150, target: 200), hotend: Temperature(actual: 33, target: 100)),
            TemperatureFrame(bed: Temperature(actual: 200, target: 200), hotend: Temperature(actual: 66, target: 100)),
            TemperatureFrame(bed: Temperature(actual: 200, target: 200), hotend: Temperature(actual: 100, target: 100))
        ]
        
        return WidgetPreviewer {
            TemperatureGraphWidget(temperatures: temperatures)
        }
    }
}
