//
//  Pokemon.swift
//  iPokedex
//
//  Created by Francisco Surroca on 11/7/19.
//  Copyright © 2019 Francisco Surroca. All rights reserved.
//

import Foundation

class Pokemon {
    var name: String!
    var url: String!
    var imageUrl: String?
    var height: Int?
    var weight: Int?
    
    init() {
    }
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
