// Copyright 2023 Metaverse World Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

/// 프로젝트 전역 SDK
final public class FncyWalletSDK {
    private let _version = "0.1.13"
    /// FncyWalletSDK 의 공유 인스턴스
    public static let shared = FncyWalletSDK()
    private var _apikey: String?
    private var _baseUrl: String
    private init() {
        _apikey = nil
        _baseUrl = ""
    }

    public static func initSDK(environment: FncyWalletSDKEnvironment) {
        FncyWalletSDK.shared.initialize(apiKey: environment.apiKey,
                                        baseURL: environment.endpoint)
    }

    private func initialize(apiKey: String,
                            baseURL: String) {
        _apikey = apiKey
        _baseUrl = baseURL
    }

    public func sdkVersion() -> String {
        return _version
    }
}

public enum FncyWalletSDKEnvironment {
    case testnet
    case mainnet
    
    var endpoint : String {
        switch self {
        case .testnet:
            return "https://devx-apis.cubeapi.io"
        case .mainnet:
            return "https://apis.cubeapi.io"
        }
    }
    
    var apiKey : String {
        return "qhswiamdxgs3vf478795tahvubrgw5rx"
    }
}

// Error parts
extension FncyWalletSDK {
    public func apiKey() throws -> String {
        guard _apikey != nil else {
            throw FncyWalletError(reason: .mustInitApiKey)
        }
        return _apikey!
    }

    public func baseURL() -> String {
        return _baseUrl
    }
}
