//
//  PokemonRequest.swift
//  PokeTask
//
//  Created by Burak AKCAN on 23.09.2022.
//

import Foundation


final class PokemonRequest{
    
    enum PokemonRequestType{
        case pokemonPage
        case pokemonDetail(name:String)
    }
    
    private let session:URLSession = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30
        config.waitsForConnectivity = true
        return URLSession(configuration: config)
    }()
    
    private let baseUrl = "https://pokeapi.co/api/v2/"
    private let requestType:PokemonRequestType
    
    private var path: String {
           switch requestType {
           case .pokemonPage:
               return baseUrl + "pokemon?limit=20&offset=0"
           case  .pokemonDetail(let name):
               return baseUrl + "pokemon/\(name)"
           }
       }
    
    init(requestType:PokemonRequestType){
        self.requestType = requestType
    }
    
    func pokemonPages(completion:@escaping (Result<PokemonPage,APIError>)->Void){
        guard let url = URL(string: path) else{
            completion(.failure(.invalidUrl))
            return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.taskError))
            }
            guard let response = response as? HTTPURLResponse else{
                completion(.failure(.invalidResponse))
                return
            }
            if response.statusCode != 200{
                completion(.failure(.invalidStatusCode(response.statusCode)))
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let pokemonPages = try decoder.decode(PokemonPage.self, from: data)
                completion(.success(pokemonPages))
            }catch{
                completion(.failure(.invalidJson))
            }
        }
    task.resume()
    }
    
    func pokemonDetail(completion:@escaping (Result<PokemonDetail,APIError>)->Void){
        guard let url = URL(string: path) else {
            completion(.failure(.invalidUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.taskError))
            }
            guard let response = response as? HTTPURLResponse else{
                completion(.failure(.invalidResponse))
                return}
            
            if response.statusCode != 200 {
                completion(.failure(.invalidStatusCode(response.statusCode)))
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let pokemonDetail = try decoder.decode(PokemonDetail.self, from: data)
                completion(.success(pokemonDetail))
            }catch{
                completion(.failure(.invalidJson))
            }

        }
        task.resume()
    }
}
