//
//  DetailsProductViewModel.swift
//  FeatureFlagDemo
//
//  Created by Benjamin BAYEL on 27/11/2020.
//

import Foundation
import Combine

final class DetailsProductViewModel: ObservableObject, Identifiable {

    enum State {
        case idle
        case loading
        case loaded(Bool)
    }

    @Published var product: ProductViewModel
    @Published var state = State.idle
    
    private var cancellableSet: Set<AnyCancellable> = []

    init(vm: ProductViewModel) {
        self.product = vm
        self.state = .loading
    }
    
    
    func load() {
        FeatureFlagHelper.shared.isExpressCheckoutEnabled
            .catch { _ in Just(false) }
            .receive(on: RunLoop.main)
            .map { result -> State in
                return State.loaded(result)
            }
            .assign(to: \.state, on: self)
            .store(in: &cancellableSet)
    }
}
