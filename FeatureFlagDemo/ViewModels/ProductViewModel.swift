//
//  ProductViewModel.swift
//  FeatureFlagDemo
//
//  Created by Benjamin BAYEL on 27/11/2020.
//

import Foundation

final class ProductViewModel: ObservableObject, Identifiable {
    @Published var imageName: String
    @Published var title: String
    @Published var brand: String
    @Published var price: String
    
    init(model: StoryProduct) {
        self.imageName = model.imageHash
        self.title = model.title
        self.brand = model.brand
        self.price = "\(model.price) €"
    }
    
    
    static func mockups() -> [ProductViewModel] {
        return [StoryProduct(title: "Sacoche", brand: "LOUIS VUITTON", price: 1540, currency: "EUR", imageHash: "1", sku: "SKU1"),
                StoryProduct(title: "Veste", brand: "LOUIS VUITTON", price: 2700, currency: "EUR", imageHash: "2", sku: "SKU2"),
                StoryProduct(title: "Etole", brand: "LOUIS VUITTON", price: 540, currency: "EUR", imageHash: "3", sku: "SKU3"),
                StoryProduct(title: "Pulse", brand: "LOUIS VUITTON", price: 1540, currency: "EUR", imageHash: "4", sku: "SKU4"),
                StoryProduct(title: "Porte document", brand: "LOUIS VUITTON", price: 1540, currency: "EUR", imageHash: "5", sku: "SKU5")]
            .map { ProductViewModel(model: $0)}
    }
}
