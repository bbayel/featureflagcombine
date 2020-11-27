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
    func refreshConfig(_ completion: (() -> Void)?)
    
    var isExpressCheckoutEnabled: AnyPublisher<Bool, Error> { get }
}

extension FeatureFlagHelperMethods {
    func refreshConfig(_ completion: (() -> Void)? = nil) {
        refreshConfig(completion)
    }
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
        settings.minimumFetchInterval = 120 * 60 // every 120 min
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "DefaultRemoteConfig")
    }
    
    
    func refreshConfig(_ completion: (() -> Void)?) {
        
        remoteConfig.ensureInitialized { [weak self] (initializationError) in
            if let initializationError = initializationError {
                print("[RemoteConfig] initialization remote config has errored: \(initializationError.localizedDescription)")
            }
            
            self?.remoteConfig.fetchAndActivate { (status, error) in
                print("[RemoteConfig] fetch remote config completed with status : [\(status)]")
                if let error = error {
                    print("[RemoteConfig] fetch remote config has errored: \(error.localizedDescription)")
                }
                DispatchQueue.main.async {
                    completion?()
                }
            }
        }
    }
    
    private func boolConfiguration(for key: FeatureFlagKeys) -> Bool {
        return remoteConfig.configValue(forKey: key.rawValue).boolValue
    }
    
    var isExpressCheckoutEnabled: AnyPublisher<Bool, Error> {
        remoteConfig.fetchAndActivate()
            .map { (_) -> Bool in
                return self.boolConfiguration(for: .expressCheckoutEnabled)
            }
            .eraseToAnyPublisher()
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
        }.eraseToAnyPublisher()
    }
}
