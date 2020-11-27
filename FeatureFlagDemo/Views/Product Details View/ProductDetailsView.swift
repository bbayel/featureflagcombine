//
//  ProductDetailsView.swift
//  FeatureFlagDemo
//
//  Created by Benjamin BAYEL on 30/10/2020.
//

import SwiftUI

struct ProductDetailsView: View {
    
    @ObservedObject var viewModel: ProductViewModel
    private let imageRadio: CGFloat = 0.7
    
    var body: some View {
        GeometryReader { geomatry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 8) {
                    Text(viewModel.brand)
                        .font(.largeTitle)
                    Text(viewModel.title)
                        .font(.title2)
                    Image(self.viewModel.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: geomatry.size.width,
                            height: geomatry.size.height * self.imageRadio
                        )
                        .background(Color.white)
                    BuyBox()
                }
                .background(Color(.systemBackground))
            }
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(viewModel: ProductViewModel.mockups().first!)
    }
}
