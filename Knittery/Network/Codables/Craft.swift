//
//  Craft.swift
//  Knittery
//
//  Created by Nick on 2022-10-04.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct Craft: Codable {
    let id: Int?
    let name: String?
    
    var toString: String { name ?? "" }
    
    init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}

extension Craft {
    static let mockData = Craft(id: 1, name: "Crochet")
    static let emptyData = Craft(id: nil, name: nil)
}
