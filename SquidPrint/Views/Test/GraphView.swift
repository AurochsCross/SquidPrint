//
//  GraphView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import SwiftUI

struct GraphView: View {
    
    let points: [Double]
    
    var body: some View {
        getPath()
            .stroke(Color.blue, lineWidth: 10)
    }
    
    private func getPath() -> Path {
        guard points.count > 1 else {
            return Path()
        }
        
        
        let step: Double = 1.0 / Double(points.count)
        var index: Double = 0
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: points.first!))
            points.dropFirst().forEach { point in
                index += 1
                path.addLine(to: CGPoint(x: step * index, y: point))
            }
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(points: [0.0, 0.3, 0.4, 1])
            .frame(width: 300, height: 150)
            .background(Color.white)
            .padding()
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}
