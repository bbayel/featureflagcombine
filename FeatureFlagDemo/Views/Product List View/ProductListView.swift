//
//  ProductListView.swift
//  FeatureFlagDemo
//
//  Created by Benjamin BAYEL on 30/10/2020.
//

import SwiftUI

struct ProductListView: View {
    
    @ObservedObject var viewModel: ProductListViewModel
    
    var padding: CGFloat = 20
    
    var body: some View {
        GeometryReader { geomatry in
            NavigationView {
                VStack(alignment: .center, spacing: 0) {
                    Text("Nouveautés 24S")
                        .font(.title)
                        .frame(width: geomatry.size.width, height: 80)
                        .background(
                            CustomShape(radius: 20, topLeft: true, topRight: true)
                                .stroke(Color(.secondarySystemFill), lineWidth: 1)
                        )
                    Spacer().frame(height: 8)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: self.padding) {
                            ForEach(self.viewModel.productViewModels) { pvm in
                                NavigationLink(
                                   destination: ProductDetailsView(viewModel: pvm)) {
                                    ProductView(viewModel: pvm)
                                        .frame(
                                            width: geomatry.size.width,
                                            height: geomatry.size.height - 80
                                        )
                                        .padding(.bottom, 20)
                                 }
                            }
                        }
                    }
                }
            }
            .background(Color(.systemBackground))
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(viewModel: ProductListViewModel(productViewModels: ProductViewModel.mockups()))
    }
}

struct CustomShape: Shape {
    let radius: CGFloat
    
    var topLeft = false
    var topRight = false
    var bottomLeft = false
    var bottomRight = false
    
    func path(in rect: CGRect) -> Path {
        var path = Path(.zero)
        
        let tl = CGPoint(x: rect.minX, y: rect.minY + (topLeft ? radius : 0))
        let tr = CGPoint(x: rect.maxX - (topRight ? radius : 0), y: rect.minY)
        let brs = CGPoint(x: rect.maxX, y: rect.maxY - (bottomRight ? radius : 0))
        let bls = CGPoint(x: rect.minX + (bottomLeft ? radius : 0), y: rect.maxY)
        
        // Start point
        path.move(to: tl)
        
        // Draw top-left corner
        if topLeft {
            let tlc = CGPoint(x: rect.minX + radius, y: rect.minY + radius)
            path.addRelativeArc(center: tlc, radius: radius, startAngle: .degrees(180), delta: .degrees(90))
        }
        path.addLine(to: tr)
        
        // Draw top-right corner
        if topRight {
            let trc = CGPoint(x: rect.maxX - radius, y: rect.minY + radius)
            path.addRelativeArc(center: trc, radius: radius, startAngle: .degrees(270), delta: .degrees(90))
        }
        
        path.addLine(to: brs)
        
        // Draw bottom-right corner
        if bottomRight {
            let brc = CGPoint(x: rect.maxX - radius, y: rect.maxY - radius)
            path.addRelativeArc(center: brc, radius: radius,
                                startAngle: .degrees(0), delta: .degrees(90))
        }
        path.addLine(to: bls)
        
        // Draw bottom-right corner
        if bottomLeft {
            let blc = CGPoint(x: rect.minX + radius, y: rect.maxY - radius)
            path.addRelativeArc(center: blc, radius: radius,
                                startAngle: .degrees(90), delta: .degrees(90))
        }
        path.addLine(to: tl)
        
        return path
    }
}
