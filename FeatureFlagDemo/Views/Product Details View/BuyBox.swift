//
//  BuyBox.swift
//  FeatureFlagDemo
//
//  Created by Benjamin BAYEL on 27/11/2020.
//

import SwiftUI
import Combine

struct BuyBox: View {
    
    @State var stateExpressCheckoutLoaded: DetailsProductViewModel.State
    
    var body: some View {
        HStack(alignment: .center, spacing: 8, content: {
            Button("Add To Cart") {
            }
            if case .loaded(let isExpressCheckoutEnabled) = stateExpressCheckoutLoaded,
               isExpressCheckoutEnabled {
                Button("Express Checkout") {
                }
            }
        })
    }
}

struct BuyBox_Previews: PreviewProvider {
    static var previews: some View {
        BuyBox(stateExpressCheckoutLoaded: .loading)
    }
}
