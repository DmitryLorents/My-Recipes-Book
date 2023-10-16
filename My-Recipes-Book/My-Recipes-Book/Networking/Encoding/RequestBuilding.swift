//
//  RequestBuilding.swift
//  My-Recipes-Book
//
//  Created by Nickolay Vasilchenko on 01.09.2023.
//

import Foundation

struct RequestBuilder {
    
    func buildRequest(with endPoint: EndPointType?) -> URLRequest? {
        
        guard let endPoint = endPoint else { return nil }
        let url = URL(string: endPoint.path, relativeTo: endPoint.baseURL)
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endPoint.httpHead
        request.httpMethod = endPoint.httpMethod.rawValue
        let urlComponents = configureURLComponents(urlRequest: request, parameters: endPoint.requestParameters)
        request.url = urlComponents?.url
        return request
    }
    
    //the function is responsible for setting parameters in the URL request (RecipeAPI requestParameters)
    private func configureURLComponents(urlRequest: URLRequest, parameters: Parameters) -> URLComponents? {
       
        guard let url = urlRequest.url else { return nil }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty else { return nil }
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let quertyItem = URLQueryItem(name: key,
                                          value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            urlComponents.queryItems?.append(quertyItem)
        }
        return urlComponents
    }
    
}
