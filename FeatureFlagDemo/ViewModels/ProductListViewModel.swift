//
//  ProductListViewModel.swift
//  FeatureFlagDemo
//
//  Created by Benjamin BAYEL on 27/11/2020.
//

import Foundation

final class ProductListViewModel: ObservableObject {
    @Published var productViewModels: [ProductViewModel]
    
    init(productViewModels: [ProductViewModel]) {
        self.productViewModels = productViewModels
    }
}
