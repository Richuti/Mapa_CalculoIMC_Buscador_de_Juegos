//
//  SuperheroDetail.swift
//  Curso_iOS
//
//  Created by Richard Diaz on 5/11/25.
//

import SwiftUI
import Charts

struct SuperheroDetail: View {
    let id: String
    
    @State var superhero: ApiNetwork.SuperheroCompleted? = nil
    @State var loading: Bool = true
    var body: some View {
        VStack{
            if(loading){
                ProgressView().tint(.white)
            } else if let superhero = superhero{
                AsyncImage(url: URL(string: superhero.image.url)){ phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable().scaledToFill().frame(height:200)
                    case .failure(let _):
                        Image(systemName: "photo.fill")
                            .foregroundStyle(Color.white)
                    default: EmptyView()
                    }
                    Text(superhero.name).bold().font(.title).foregroundColor(.white)
                    ForEach(superhero.biography.aliases, id: \.self){
                        alias in Text(alias).foregroundColor(.gray).italic()
                    }
                    SuperheroStats(stats: superhero.powerstats)
                    Spacer()
                }
            }
        }.padding(16).frame(maxWidth: .infinity, maxHeight: .infinity).background(.backgroundApp).onAppear{
            Task{
                do{
                  superhero = try await ApiNetwork().getHeroById(id: id)
                }catch{
                    superhero = nil
                }
                loading = false
            }
        }
    }
}


struct SuperheroStats: View {
    let stats: ApiNetwork.Powerstats
    var body: some View {
        VStack{
            Chart{
                SectorMark(angle: .value("Count", Int(stats.combat) ?? 0), innerRadius: .ratio(0.5), angularInset: 2).cornerRadius(5).foregroundStyle(by: .value("Category", "Combate")) //innerRadius es el grosor del pastel
                SectorMark(angle: .value("Count", Int(stats.durability) ?? 0), innerRadius: .ratio(0.5), angularInset: 2).cornerRadius(5).foregroundStyle(by: .value("Category", "Durabilidad")) // angularInset es la separacion
                SectorMark(angle: .value("Count", Int(stats.intelligence) ?? 0), innerRadius: .ratio(0.5), angularInset: 2).cornerRadius(5).foregroundStyle(by: .value("Category", "Inteligencia"))
                SectorMark(angle: .value("Count", Int(stats.power) ?? 0), innerRadius: .ratio(0.5), angularInset: 2).cornerRadius(5).foregroundStyle(by: .value("Category", "Poder"))
                SectorMark(angle: .value("Count", Int(stats.speed) ?? 0), innerRadius: .ratio(0.5), angularInset: 2).cornerRadius(5).foregroundStyle(by: .value("Category", "Velocidad"))
                SectorMark(angle: .value("Count", Int(stats.strength) ?? 0), innerRadius: .ratio(0.5), angularInset: 2).cornerRadius(5).foregroundStyle(by: .value("Category", "Fuerza"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 350)
        .background(.white)
        .cornerRadius(16)
        .padding(24)
    }
}
//#Preview {
//    SuperheroDetail(id: "2")
//}
