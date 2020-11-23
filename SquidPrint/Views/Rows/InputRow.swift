//
//  InputRow.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import SwiftUI

struct InputRow: View {
    var title: String
    var placeholder: String
    
    @Binding var input: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            TextField(placeholder, text: $input)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct InputRow_Previews: PreviewProvider {
    static var previews: some View {
        return InputRow(title: "Test title", placeholder: "Placeholder", input: .constant(""))
    }
}
