//
//  ProductView.swift
//  FeatureFlagDemo
//
//  Created by Benjamin BAYEL on 30/10/2020.
//

import SwiftUI

struct ProductView: View {
    @ObservedObject var viewModel: ProductViewModel
    
    private let imageRadio: CGFloat = 0.7
    
    var body: some View {
        GeometryReader { geomatry in
            VStack {
                Image(self.viewModel.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: geomatry.size.width,
                        height: geomatry.size.height * self.imageRadio
                )
                    .background(Color.white)
                
                Spacer()
                    .frame(width: geomatry.size.width - 40, height: 1)
                    .background(Color.gray.opacity(0.3))
                    .padding()
                Text(self.viewModel.brand)
                    .font(.system(size: 16))
                    .bold()
                    .padding(.bottom, 5)
                    .foregroundColor(.primary)
                Text(self.viewModel.title)
                    .font(.body)
                    .padding(.bottom, 5)
                    .foregroundColor(.primary)
                Text(self.viewModel.price)
                    .font(.body)
                    .padding(.bottom, 20)
                    .foregroundColor(.primary)
            }
            .background(Color(.systemBackground))
            .mask(CustomShape(radius: 10, bottomLeft: true, bottomRight: true))
            .shadow(color: Color(.systemFill), radius: 5, x: 1, y: 1)
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(viewModel: ProductViewModel.mockups().first!)
    }
}
