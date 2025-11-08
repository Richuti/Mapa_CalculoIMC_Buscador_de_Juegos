//
//  LabelExample.swift
//  Curso_iOS
//
//  Created by Richard Diaz on 2/11/25.
//

import SwiftUI

struct LabelExample: View {
    var body: some View {
        Label("Vete pa la pinga", systemImage: "trash")
        Label(title: {Text("Vete al pingon")},
              icon: {Image( "swiftui")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)})
    }
}

#Preview {
    LabelExample()
}

