//
//  NetworkRequest.swift
//  Weather
//
//  Created by Андрей on 20.02.2021.
//

import UIKit

class Network {
    
    func networkRequest(_ api: String,complition: @escaping(_ data: Data) -> ()) {
        
        if let url = URL(string: api) {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let data = data {
                   complition(data)
                }
                
                if let response = response {
                    print(response)
                }
                
                if let error = error {
                    print(error)
                }
            }
            dataTask.resume()
        }
    }
}
