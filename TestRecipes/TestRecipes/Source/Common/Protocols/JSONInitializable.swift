//
//  JSON.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-27.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation

public protocol JSONInitializable {
    init(withJSON json: [String: Any]) throws
}
