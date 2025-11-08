//
//  SuperHeroSearcher.swift
//  Curso_iOS
//
//  Created by Richard Diaz on 5/11/25.
//

import SwiftUI

struct SuperHeroSearcher: View {
    @State var superHeroName: String = ""
    @State var wrapper: ApiNetwork.Wrapper? = nil
    @State var loading: Bool = false
    var body: some View {
        VStack{
            TextField("", text: $superHeroName, prompt: Text("Superman...").bold().font(.title2).foregroundColor(.gray))
                .bold()
                .font(.title2)
                .foregroundColor(.white)
                .padding(16)
                .border(.purple, width: 1.5)
                .padding(8)
                .autocorrectionDisabled()
                .onSubmit {
                    loading = true
                    Task{
                        do{
                            wrapper = try await ApiNetwork().getHeroesQuery(query: superHeroName)
                        }catch{
                            print("Error")
                        }
                        loading = false
                    }
                }
            if(loading){
                ProgressView().tint(.white)
            }
            NavigationStack{
                List(wrapper?.results ?? []){superhero in
                    ZStack{
                    SuperheroItem(superhero: superhero)
                        NavigationLink(destination: SuperheroDetail(id: superhero.id)){
                            EmptyView()}.opacity(0)
                    }.listRowBackground(Color.backgroundApp)
                }.listStyle(.plain)
            }
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.backgroundApp)
    }
}

struct SuperheroItem: View {
    let superhero: ApiNetwork.Superhero
    var body: some View {
        ZStack{
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
            }
            
            VStack{
                Spacer()
                Text(superhero.name)
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white.opacity(0.5))
                
            }
        }.frame(height: 200).cornerRadius(32)
    }
}

//#Preview {
//    SuperHeroSearcher()
//}
