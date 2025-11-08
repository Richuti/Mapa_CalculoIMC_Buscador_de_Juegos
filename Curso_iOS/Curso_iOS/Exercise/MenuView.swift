//
//  MenuView.swift
//  Curso_iOS
//
//  Created by Richard Diaz on 2/11/25.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink(destination: IMCView()){
                    Text("IMC Calculator")
                }
                NavigationLink(destination: SuperHeroSearcher()){
                    Text("Super Hero")
                }
                NavigationLink(destination: FavPlaces()){
                    Text("Lugares Favoritos")
                }
            }
        }
    }
}

//#Preview {
//    MenuView()
//}
