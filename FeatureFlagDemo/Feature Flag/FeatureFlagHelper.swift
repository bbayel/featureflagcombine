//
//  FeatureFlagHelper.swift
//  FeatureFlagDemo
//
//  Created by Benjamin BAYEL on 27/11/2020.
//

import Foundation
import Combine
import FirebaseRemoteConfig

protocol FeatureFlagHelperMethods {
    var isExpressCheckoutEnabled: AnyPublisher<Bool, Error> { get }
}

private enum FeatureFlagKeys: String {
    case expressCheckoutEnabled = "express_checkout_enabled"
}

class FeatureFlagHelper: FeatureFlagHelperMethods {
    
    static let shared: FeatureFlagHelperMethods = FeatureFlagHelper()
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    init() {
        let settings = RemoteConfigSettings()
        settings.fetchTimeout = 10.0 // timeout to 10s
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "DefaultRemoteConfig")
    }

    var isExpressCheckoutEnabled: AnyPublisher<Bool, Error> {
        return booleanPublisher(for: .expressCheckoutEnabled)
    }
    
    private func booleanPublisher(for key: FeatureFlagKeys) -> AnyPublisher<Bool, Error> {
        remoteConfig.fetchAndActivate()
            .map { (_) -> Bool in
                return self.boolConfiguration(for: key)
            }
            .eraseToAnyPublisher()
    }
    
    private func boolConfiguration(for key: FeatureFlagKeys) -> Bool {
        return remoteConfig.configValue(forKey: key.rawValue).boolValue
    }
}


// MARK: Make RemoteConfig Combinable
extension RemoteConfig {
    
    public func fetchAndActivate() -> AnyPublisher<RemoteConfigFetchAndActivateStatus, Error> {
        Future<RemoteConfigFetchAndActivateStatus, Error> { [weak self] promise in
            self?.fetchAndActivate { result, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(result))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
