//
//  ContentView.swift
//  Curso_iOS
//
//  Created by Richard Diaz on 2/11/25.
//

import SwiftUI

struct Exercise1: View {
    var body: some View {
        VStack{
            HStack{
                Rectangle().foregroundColor(.blue)
                Rectangle().foregroundColor(.orange)
                Rectangle().foregroundColor(.yellow)
            }.frame(height: 100)
            Rectangle()
                .frame(height: 100)
                .foregroundColor(.orange)
            HStack{
                Circle().foregroundColor(.green)
                Rectangle()
                Circle().foregroundColor(.indigo)
            }.frame(height: 250)
            Rectangle().frame(height: 100).foregroundColor(.orange)
            HStack{
                Rectangle().foregroundColor(.blue)
                Rectangle().foregroundColor(.orange)
                Rectangle().foregroundColor(.yellow)
            }.frame(height: 100)
        }
        .background(.red)
    }
}

//#Preview {
//    Exercise1()
//}
