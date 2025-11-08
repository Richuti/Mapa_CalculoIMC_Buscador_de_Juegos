//
//  ImageExample.swift
//  Curso_iOS
//
//  Created by Richard Diaz on 2/11/25.
//

import SwiftUI

struct ImageExample: View {
    var body: some View {
        Image("swiftui")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
        
        Image(systemName: "figure.walk").resizable().frame(width:50, height: 50)
    }
}

//#Preview {
//    ImageExample()
//}
