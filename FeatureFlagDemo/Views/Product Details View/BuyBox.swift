//
//  BuyBox.swift
//  FeatureFlagDemo
//
//  Created by Benjamin BAYEL on 27/11/2020.
//

import SwiftUI
import Combine

struct BuyBox: View {
    
    @Binding var stateExpressCheckoutLoaded: DetailsProductViewModel.State
    
    //@ViewBuilder
    var body: some View {
        VStack(alignment: .center, spacing: 8, content: {
            Button("Add To Cart") {
                
            }
            .foregroundColor(.primary)
            .frame(height: 40)
            if case .loaded(let isExpressCheckoutEnabled) = stateExpressCheckoutLoaded,
               isExpressCheckoutEnabled {
                Button("Express Checkout") {
                }
                .foregroundColor(.red)
                .frame(height: 40)
            }
        })
    }
}

struct BuyBox_Previews: PreviewProvider {
    
    @State static var value: DetailsProductViewModel.State = .loaded(true)
    
    static var previews: some View {
        BuyBox(stateExpressCheckoutLoaded: $value)
    }
}
