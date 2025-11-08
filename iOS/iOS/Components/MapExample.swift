//
//  MaoExample.swift
//  Curso_iOS
//
//  Created by Richard Diaz on 7/11/25.
//

import SwiftUI
import MapKit

struct MapExample: View {
    @State var position = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 12.095502, longitude: -86.212647),
        span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    ))
    
    var body: some View {
        ZStack{
            MapReader{proxy in
                
                Map(position: $position){
//                    Marker("Casita", coordinate: CLLocationCoordinate2D(latitude: 12.095502, longitude: -86.212647))
                    
                    Annotation("Casita", coordinate: CLLocationCoordinate2D(latitude: 12.095502, longitude: -86.212647)){
                        Circle().frame(height: 30)
                    }.annotationTitles(.visible)
                           }
                    .mapStyle(.hybrid(elevation: .realistic, showsTraffic: true))//tenemos .imagery que es satelital sin el nombre de los sitios y .standard que es el normal //este que tengo puesto puedes ver el estado de las elevaciones y ademas el trafico en tiempo real
                //                .onMapCameraChange { context in
                //                    print("Estamos en \(context.region)")
                //                }
                    .onMapCameraChange(frequency: .continuous) { context in
                        print("Estamos en \(context.region)")
                    }
                    .onTapGesture { coord in
                        if let coordinates = proxy.convert(coord, from: .local){
                            withAnimation{
                                position = MapCameraPosition.region(MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude),
                                    span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                                ))
                            }
                        }
                        
                    }
            }
            VStack{
                Spacer()
                HStack{
                    Button("Ir al Sur"){
                        withAnimation{
                            position = MapCameraPosition.region(MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: 12.095502, longitude: -86.212647),
                                span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                            ))
                        }
                    }.padding(32).background(.white).padding()
                    Button("Ir al Norte"){
                        withAnimation{
                            position = MapCameraPosition.region(MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: 12.108739, longitude: -86.256962),
                                span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                            ))
                        }
                    }.padding(32).background(.white).padding()
                }
            }
        }
    }
}

//#Preview {
//    MapExample()
//}
