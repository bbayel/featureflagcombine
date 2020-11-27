//
//  StoryProduct.swift
//  24Stories
//
//  Created by Benjamin BAYEL on 25/06/2020.
//  Copyright © 2020 24S. All rights reserved.
//

import Foundation

class StoryProduct {
    
    let title: String
    let brand: String
    let price: Int
    let currency: String
    let imageHash: String
    let sku: String
    
    init(
        title: String,
         brand: String,
         price: Int,
         currency: String,
         imageHash: String,
         sku: String
    ) {
        self.title = title
        self.brand = brand
        self.price = price
        self.currency = currency
        self.imageHash = imageHash
        self.sku = sku
    }
}


extension StoryProduct: Equatable {
    static func == (lhs: StoryProduct, rhs: StoryProduct) -> Bool {
        return lhs.sku == rhs.sku
    }
}
