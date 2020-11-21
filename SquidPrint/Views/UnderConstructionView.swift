//
//  UnderConstructionView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-21.
//

import SwiftUI

struct UnderConstructionView: View {
    let viewName: String
    
    var body: some View {
        Text("\(viewName) is under construction")
            .font(.title)
            .bold()
            .multilineTextAlignment(.center)
    }
}

struct UnderConstructionView_Previews: PreviewProvider {
    static var previews: some View {
        UnderConstructionView(viewName: "Some very ass long name")
    }
}
