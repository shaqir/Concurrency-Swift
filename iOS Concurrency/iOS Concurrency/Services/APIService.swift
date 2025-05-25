//
//  APIService.swift
//  iOS Concurrency
//
//  Created by Sakir Saiyed on 25/05/25.
//

import Foundation

struct APIService{
    let urlString: String
    
    //Async Await version
    func getJSON<T: Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                               keyDecodigStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) async throws -> T{
        
        guard let url = URL(string: urlString)
        else { throw APIError.invalidURL }
        
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse  = response as? HTTPURLResponse, httpResponse.statusCode == 200
            else {
                throw APIError.invalidResponseStatus
            }
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            }
            catch {
                throw APIError.decodingError(error.localizedDescription)
            }
        }
        catch{
            throw APIError.dataTaskError(error.localizedDescription)
        }
        
    }
   
    //Completion Handler version
    func getJSON<T: Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                keyDecodigStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                completion: @escaping (Result<T, APIError>) -> Void){
        
        guard let url = URL(string: urlString)
        else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let httpResponse  = response as? HTTPURLResponse, httpResponse.statusCode == 200
            else {
                completion(.failure(.invalidResponseStatus))
                return
            }
            guard error == nil else {
                completion(.failure(.dataTaskError(error!.localizedDescription)))
                return
            }
            guard let data = data else {
                completion(.failure(.corruptData))
                return
            }
            
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            }
            catch {
                completion(.failure(.decodingError(error.localizedDescription)))
            }
            
            
        }.resume()
        
        
    }
}


enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError(String)
    case corruptData
    case decodingError(String)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .invalidResponseStatus:
            return NSLocalizedString("Invalid response status", comment: "")
        case .dataTaskError(let message):
            return message
        case .corruptData:
            return NSLocalizedString("Corrupt data", comment: "")
        case .decodingError(let String):
            return String
        case .networkError(let error):
            return error.localizedDescription
        }
    }
}
