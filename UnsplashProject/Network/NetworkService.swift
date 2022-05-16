//U-N00B-or-Bot

import Foundation
import UIKit
enum Errors: Error {
    case invalidURL
    case noData
    case decodingError
}


class NetworkService {
    
    
    
    func fetch<T: Codable>(dataType: T.Type, from searchTerm: String?, completion: @escaping(Result<T, Errors>)-> Void){
        
        
       let param = self.getParameters(searchTerm: searchTerm)
        let url = self.urlCreator(parameters: param)
       
        
     
    
        
        
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization":"Client-ID \(ApiKey.shared.apiAccessKey)"]
        request.httpMethod = "get"
     
        URLSession.shared.dataTask(with: request) {data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do{
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(model))
                }}
                catch{
                    completion(.failure(.decodingError.self))
                }

        }.resume()
    }
 
    func getParameters(searchTerm: String?)-> [String:String]{
        var parameters = [String:String]()
         
       
        parameters["query"] = searchTerm ?? ""
        parameters["count"] = String(30)
  
        return parameters
    }
    

    func urlCreator(parameters: [String:String])-> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos/random"
        components.queryItems = parameters.map{URLQueryItem(name: $0, value: $1)}
     

        return components.url!
    }
    
}
