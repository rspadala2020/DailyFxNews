//
//  APIService.swift
//  dailyFxNews
//
//  Created by raja padala on 06/11/21.
//

import UIKit
import Foundation

class APIService<T>: NSObject {
    let session = URLSession.shared
    private var completionHandler: ((_ model: T?, _ error:String?, _ errorCode:Int?) -> Void)?
    
    func fetch<T:Decodable>(model:T.Type, type:HTTPMethod = .get , urlString:String, completion:  (@escaping (_ model:T?, _ error:String? , _ errorCode:Int?) -> Void), parameters: [String: Any]? = nil, queryParameters: [String: String]? = nil , headers: [String: String]? = nil) {
        
            if let url = URL(string: urlString) {
                let dataTask = session.dataTask(with: url) { (data, response, error) in
                    let response = response as? HTTPURLResponse
                    if error == nil, let responseData = data {
                        do {
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(T.self, from: responseData)
                            completion(responseModel, nil ,response?.statusCode)
                        } catch {
                                completion(nil, error.localizedDescription , response?.statusCode)
                        }
                    } else {
                        completion(nil, error?.localizedDescription , response?.statusCode)
                    }
                }
                dataTask.resume()
            } else {
                
            }
        
    }
}

public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

