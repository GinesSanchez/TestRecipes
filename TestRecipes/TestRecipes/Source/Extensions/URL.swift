//
//  URL.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-27.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation

extension URL {

    public init?(unsecureUrlString: String) {
        let secureUrlString = unsecureUrlString.replacingOccurrences(of: "http:", with: "https:")
        guard let url = URL(string: secureUrlString) else { return nil }
        self = url
    }
}
