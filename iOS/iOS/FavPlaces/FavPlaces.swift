//
//  FavPlaces.swift
//  Curso_iOS
//
//  Created by Richard Diaz on 8/11/25.
//

import SwiftUI
import MapKit

struct FavPlaces: View {
    
    @State var position = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 12.105642, longitude: -86.248166), span:
                            MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
         )
    )
    
    @State var places: [Place] = []
    
    @State var showPopUp: CLLocationCoordinate2D? = nil
    
    @State var name: String = ""
    
    @State var fav: Bool = false
    
    @State var showSheet: Bool = false
    
    let height = stride(from: 0.3, through: 0.3, by: 0.1).map{PresentationDetent.fraction($0)}
    
    var body: some View {
        ZStack{
            MapReader{ proxy in
                Map(position: $position){
                    ForEach(places) { place in
                        Annotation(place.name, coordinate: place.coordinate) {
                            let color = place.fav ? Color.yellow : Color.black
                            Circle()
                                .fill(color)
                                .frame(width: 35, height: 35)
                                .overlay(Circle().stroke(Color.black, lineWidth: 1))
                                .background(Circle().fill(Color.white))
                        }
                    }
                }
                .onTapGesture { coord in
                    if let coordinates = proxy.convert(coord, from: .local){
                        showPopUp = coordinates
                    }
                }
                .overlay{
                    VStack{
                        Button("Mostrar vista"){
                            showSheet = true
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(.white)
                        .cornerRadius(16)
                        .padding(16)
                        Spacer()
                    }
                }
            }
            if showPopUp != nil{
                let view = VStack{
                    Text("Anadir Localizacion").font(.title2).bold()
                    Spacer()
                    TextField("Nombre: ", text: $name).padding(.bottom, 8)
                    Toggle("Es un lugar favorito?", isOn: $fav)
                    Spacer()
                    Button("Guardar"){
                        savePlace(name: name, fav: fav, coordinate: showPopUp!)
                        clearForm()
                    }
                }
                withAnimation{
                    CustomDialog(closeDialog: {
                        showPopUp = nil
                    }, onDismissOutside: true, content: view)
                }
            }
        }.sheet(isPresented: $showSheet){
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(places){ place in
                        let color = place.fav ? Color.yellow.opacity(0.5) : Color.gray.opacity(0.5)
                        VStack{
                            Text(place.name).font(.title3).bold()
                        }.frame(width: 150, height: 100).overlay{
                            RoundedRectangle(cornerRadius: 20).stroke(color, lineWidth: 1)
                        }.shadow(radius: 5).padding(.horizontal, 8)
                            .onTapGesture{
                                animateCamera(coordinates: place.coordinate)
                                showSheet = false
                            }
                    }
                }
            }.presentationDetents(Set(height))
        }.onAppear{
            loadPlaces()
        }
    }
    
    func animateCamera(coordinates: CLLocationCoordinate2D){
        withAnimation{
            position = MapCameraPosition.region(
                MKCoordinateRegion(center: coordinates, span:
                                    MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                 )
            )
        }
    }
        
    func savePlace(name: String, fav: Bool, coordinate: CLLocationCoordinate2D){
        let place = Place(name: name, coordinate: coordinate ,fav: fav)
        places.append(place)
        savePlaces()
    }
    
    func clearForm(){
        name = ""
        fav = false
        showPopUp = nil
    }
    
}

//#Preview {
//    FavPlaces()
//}

extension FavPlaces{
    func savePlaces(){
        if let encodeData = try? JSONEncoder().encode(places){
            UserDefaults.standard.set(encodeData, forKey: "places")
        }
    }
    
    func loadPlaces(){
        if let savedPlaces = UserDefaults.standard.data(forKey: "places"),
           let decodedPlaces = try? JSONDecoder().decode([Place].self, from: savedPlaces){
            places = decodedPlaces
        }
    }
}
