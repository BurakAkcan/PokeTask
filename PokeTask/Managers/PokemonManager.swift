//
//  PokemonManager.swift
//  PokeTask
//
//  Created by Burak AKCAN on 23.09.2022.
//

import Foundation
import UIKit

final class PokemonManager{
    
    static let shared = PokemonManager()
    private init(){}
    let cache         = NSCache<NSString,UIImage>()
    
    func getPokemonDetails(completion:@escaping (PokemonDetails?)->Void){
        PokemonManager.shared.getPokemonPages { pokePage in
            guard let pokePage = pokePage else {
                completion(nil)
                return
            }
            let group = DispatchGroup()
            var pokemonDetails:PokemonDetails = []
            for pokemon in pokePage.results{
                group.enter()
                PokemonManager.shared.getPokemon(name: pokemon.name) { pokemonDetail in
                    if let pokemonDetail = pokemonDetail {
                        pokemonDetails.append(pokemonDetail)
                    }
                    group.leave()
                }
            }
            
            group.notify(queue: .main){
                pokemonDetails.sort {$0.id<$1.id}
                completion(pokemonDetails)
            }
        }
    }
    
    
    func getPokemonPages(completion:@escaping (PokemonPage?)->Void){
        let request = PokemonRequest(requestType: .pokemonPage)
        request.pokemonPages { result in
            switch result {
            case .success(let pages):
                completion((pages))
            case .failure(let error):
                completion((nil))
                print(error.localizedDescription)
            }
        }
    }
    
    func getPokemon(name:String,completion:@escaping (PokemonDetail?)->Void){
        let request = PokemonRequest(requestType: .pokemonDetail(name:name))
        
        request.pokemonDetail { result in
            switch result {
            case .success(let detail):
                completion(detail)
            case .failure(let error):
                completion(nil)
                print(error.localizedDescription)
            }
        }
    }
    
    func downloadImage(from id:Int,completion:@escaping(UIImage?)->Void){
        let urlString = "\(NetworkImageConstant.imageUrl)\(id).png"
        let cacheKey = NSString(string:urlString)
        if let image = cache.object(forKey: cacheKey){
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else{completion(nil)
                  return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
}
