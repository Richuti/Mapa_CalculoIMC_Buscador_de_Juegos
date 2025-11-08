//
//  TextExample.swift
//  Curso_iOS
//
//  Created by Richard Diaz on 2/11/25.
//

import SwiftUI

struct TextExample: View {
    var body: some View {
        VStack{
            Text("Hola Mundo").font(.headline)
            Text("Custom").font(.system(size: 40, weight: .bold,design: .monospaced))
                          .bold()
                          .underline()
                          .foregroundColor(.red)
            Text("Richard Richard Richard Richard Richard").frame(width: 100).lineLimit(3)
        }
    }
}

#Preview {
    TextExample()
}
