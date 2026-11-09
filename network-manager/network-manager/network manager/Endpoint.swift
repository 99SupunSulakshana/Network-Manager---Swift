//
//  Endpoint.swift
//  network-manager
//
//  Created by S Sulakshana on 2026-11-01.
//

import Foundation

struct Endpoint {
    let urlString: String
    let method: HTTPMethod
    private(set) var headers: [String : String]
    
    init(urlString: String, method: HTTPMethod, headers: [String : String] = [:]) {
        self.urlString = urlString
        self.method = method
        self.headers = headers
    }
    
    mutating func addHeader(_ value: String, forHTTPHeaderField: String){
        headers[forHTTPHeaderField] = value
    }
    
    func buildRequest() throws(NetworkManagerError) -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw .badURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        for(key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
