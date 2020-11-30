//
//  ProductDetailsView.swift
//  FeatureFlagDemo
//
//  Created by Benjamin BAYEL on 30/10/2020.
//

import SwiftUI

struct ProductDetailsView: View {
    
    @ObservedObject var viewModel: DetailsProductViewModel
    private let imageRadio: CGFloat = 0.7
    
    var body: some View {
        GeometryReader { geomatry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 8) {
                    Text(viewModel.product.brand)
                        .font(.largeTitle)
                    Text(viewModel.product.title)
                        .font(.title2)
                    Image(self.viewModel.product.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: geomatry.size.width,
                            height: geomatry.size.height * self.imageRadio
                        )
                        .background(Color.white)
                    BuyBox(stateExpressCheckoutLoaded: $viewModel.state)
                        .onAppear(perform: {
                            viewModel.load()
                        })
                }
                .background(Color(.systemBackground))
            }
        }
    }
    
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(viewModel: DetailsProductViewModel(vm: ProductViewModel.mockups().first!))
    }
}
