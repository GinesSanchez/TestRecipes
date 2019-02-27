//
//  NetworkManagerType.swift
//  test-weather
//
//  Created by Ginés Sánchez on 2019-02-20.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import UIKit

protocol NetworkManagerType {

    /// Retrives a URL
    ///
    /// - Parameter
    ///     - apiScheme: Https or http (String).
    ///     - apiHost: Url base (String).
    ///     - apiPath: path for the request (String).
    ///     - parameters: dictionary with parameters [key: value]
    /// - Returns: URL
    func createURLWith(apiScheme: String, apiHost: String, apiPath: String, parameters: [String:Any]) -> URL

    /// Get json from URL
    ///
    /// - Parameter
    ///     - url: url for the get request.
    ///     - completionHandler: will be triggred when the request is done. If it is successfull, the json in a dictionary format is returned. Error will be nil if successful. If there is an error, an error is returned, and dictionary will be nil.
    func getJson(url: URL, completionHandler: @escaping ([String: Any]?, Error?) -> Void)

    /// Get data asynchronously from URL
    ///
    /// - Parameter
    ///     - url: url for the get request.
    ///     - completionHandler: will be triggred when the request is done. If it is successfull, the data is returned. Error will be nil if successful. If there is an error, an error is returned, and dictionary will be nil. The response will have meta information about the request.
    func getData(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)

    /// Get image asynchronously from URL
    ///
    /// - Parameter
    ///     - url: url for the get request.
    ///     - completionHandler: will be triggred when the request is done. If it is successfull, the image is returned. Error will be nil if successful. If there is an error, an error is returned, and dictionary will be nil.
    func getImage(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void)
}
