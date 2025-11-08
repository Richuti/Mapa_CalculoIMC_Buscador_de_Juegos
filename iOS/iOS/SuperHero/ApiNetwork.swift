//
//  ApiNetwork.swift
//  Curso_iOS
//
//  Created by Richard Diaz on 5/11/25.
//

import Foundation

class ApiNetwork{
    
    struct Wrapper: Codable{
        let results: [Superhero]
    }
    
    struct Superhero: Codable, Identifiable{
        let id: String
        let name: String
        let image: ImageSuperhero
    }
    
    struct ImageSuperhero: Codable{
        let url: String
    }
    
    struct SuperheroCompleted: Codable{
        let id: String
        let name: String
        let image: ImageSuperhero
        let powerstats: Powerstats
        let biography: Biography
    }
    
    struct Powerstats: Codable{
        let intelligence: String
        let strength: String
        let speed: String
        let durability: String
        let power: String
        let combat: String
    }
    
    struct Biography: Codable{
        let alignment: String
        let publisher: String
        let aliases: [String]
        let fullName: String
        
        enum CodingKeys: String, CodingKey{
            case fullName = "full-name"
            case alignment = "alignment"
            case aliases = "aliases"
            case publisher = "publisher"
        }
    }
    
    func getHeroesQuery(query: String) async throws -> Wrapper{
        let url = URL(string: "https://superheroapi.com/api/bc1356391aa59fb33f9d51714a77e41e/search/\(query)")!
        
        let (data, _ ) = try await URLSession.shared.data(from: url)
        
        let wrapped = try JSONDecoder().decode(Wrapper.self, from: data)
        
        return wrapped
    }
    
    func getHeroById(id: String) async throws -> SuperheroCompleted{
        let url = URL(string: "https://superheroapi.com/api/bc1356391aa59fb33f9d51714a77e41e/\(id)")!
        
        let (data, _ ) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(SuperheroCompleted.self, from: data)
        
        
    }
}
