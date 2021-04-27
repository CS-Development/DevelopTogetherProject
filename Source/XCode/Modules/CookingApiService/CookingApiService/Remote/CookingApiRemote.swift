//
//  CookingApiRemote.swift
//  CookingApiService
//
//  Created by Christian Slanzi on 26.04.21.
//

import NetworkingService

class CookingApiRemote: CookingApiService {
    
    private var url: URL
    private var client: HTTPClient
    private var apiKey: String?

    public init(url: URL, client: HTTPClient, apiKey: String? = nil) {
        self.url = url
        self.client = client
        self.apiKey = apiKey
    }
    
    func searchRecipes(completion: @escaping (RecipesSearchResult) -> Void) {
        
        if let key = apiKey {
            client.urlQueryParameters.add(value: "\(key)", forKey: "apiKey")
        }
        
        client.makeRequest(toURL: url.appendingPathComponent("recipes/complexSearch"), withHttpMethod: .get) { [weak self] result in
            guard self != nil else { return }
            
            print("\n\nResponse HTTP Headers:\n")
            
            if let response = result.response {
                
                if response.statusCode != 200 {
                    
                    completion(.failure(.invalidData))
                    
                    return
                }
                
            }  else {
                completion(.failure(.connectivity))
                return
            }
            
            if let data = result.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let userData = try? decoder.decode(RecipesSearchResultDTO.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                
                print(userData.description)
                completion(.success(userData))
                
            } else {
                completion(.failure(.invalidData))
            }
        }
    }
}