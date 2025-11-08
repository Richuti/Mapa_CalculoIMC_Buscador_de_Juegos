//
//  ButtonExample.swift
//  Curso_iOS
//
//  Created by Richard Diaz on 2/11/25.
//

import SwiftUI

struct ButtonExample: View {
    var body: some View {
        Button("Hola"){
            print("Hola putonga")
        }
        Button(action: {print("Hola")}, label: {Text("Hola")
                .frame(width: 100, height: 50)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(10)
        })
    }
}

struct Counter: View {
    @State var suscribersNumber = 0
    var body: some View {
        Button(action: {suscribersNumber += 1}, label: {Text("Suscriptores: \(suscribersNumber)")
                .bold()
                .font(.title)
                .frame(height: 50)
                .foregroundColor(.white)
                .background(.red)
                .cornerRadius(10)
        })
    }
}

#Preview {
    Counter()
}
