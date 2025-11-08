//
//  Place.swift
//  Curso_iOS
//
//  Created by Richard Diaz on 8/11/25.
//

import Foundation
import MapKit

struct Place: Identifiable, Codable{
    let id: UUID = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    var fav: Bool
    
    enum CodingKeys: CodingKey {
        case id, name, fav, latitude, longitude
    }
    
    init(id: UUID = UUID(), name: String, coordinate: CLLocationCoordinate2D, fav: Bool) {
        self.name = name
        self.coordinate = coordinate
        self.fav = fav
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        name = try container.decode(String.self, forKey: .name)
        fav = try container.decode(Bool.self, forKey: .fav)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
        try container.encode(name, forKey: .name)
        try container.encode(fav, forKey: .fav)
        try container.encode(id, forKey: .id)
    }
}
