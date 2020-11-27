//
//  BuyBox.swift
//  FeatureFlagDemo
//
//  Created by Benjamin BAYEL on 27/11/2020.
//

import SwiftUI
import Combine
struct BuyBox: View {
    
    @State private var isExpressCheckoutEnabled: AnyPubls
    
    var body: some View {
        HStack(alignment: .center, spacing: 8, content: {
            Button("Add To Cart") {
//                            Text("Add to cart")
            }
            FeatureFlagHelper.shared.isExpressCheckoutEnabled.flatMap { (<#Bool#>) -> Publisher in
                <#code#>
            }
            Button("Express Checkout") {
//                            Text("ExpressCheckout")
            }
            .hidden()
        })
    }
}

struct BuyBox_Previews: PreviewProvider {
    static var previews: some View {
        BuyBox()
    }
}
