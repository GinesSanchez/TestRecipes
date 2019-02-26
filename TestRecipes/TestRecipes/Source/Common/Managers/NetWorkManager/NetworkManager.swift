//
//  NetworkManager.swift
//  test-weather
//
//  Created by Ginés Sánchez on 2019-02-20.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation

final class NetworkManager: NetworkManagerType {

    func createURLWith(apiScheme: String, apiHost: String, apiPath: String, parameters: [String:Any]) -> URL {
        var components = URLComponents()
        components.scheme = apiScheme
        components.host = apiHost
        components.path = apiPath

        if !parameters.isEmpty {
            components.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }

        return components.url!
    }

    func getJson(with url: URL, completionHandler: @escaping ([String: Any]?, Error?) -> Void) {

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                completionHandler(json, nil)
            } catch let error as NSError {
                completionHandler(nil, error)
            }
        }

        task.resume()
    }
}
