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
import Alamofire

public let WALLETAPI = WalletAPI.shared

// API
public class WalletAPI {
    // singleton
    public static let shared = WalletAPI()

    public var session: Session

    private init() {
        let walletApiSessionConfigration: URLSessionConfiguration = URLSessionConfiguration.default
        walletApiSessionConfigration.tlsMinimumSupportedProtocolVersion = .TLSv12

        self.session = Session(configuration: walletApiSessionConfigration)
    }
}

extension WalletAPI {

    static var timeoutValue: TimeInterval = 30.0

    private func getRequestHeader(_ authToken: String) throws -> HTTPHeaders {
        var httpHeaders = HTTPHeaders(["Content-Type": "application/json",
                                       "Api-Key": try FncyWalletSDK.shared.apiKey()])
        httpHeaders.add(.authorization(bearerToken: authToken))
        return httpHeaders
    }

    public func request<T: ResultPresentable>(_ service: APIRequest, authToken: String? = nil) async throws -> T {
        guard let authToken = authToken else {
            throw FncyWalletError(reason: .tokenNotFound)
        }

        let requestHeader = try getRequestHeader(authToken)

        let response = await session.request(service.requestUrl,
                                             method: service.method,
                                             parameters: service.parameters,
                                             encoding: service.method == .get ?
                                             URLEncoding.default : JSONEncoding.default,
                                             headers: requestHeader) { urlRequest in
            urlRequest.timeoutInterval = Self.timeoutValue
        }.serializingDecodable(FncyWalletResponse<T>.self).response

        switch response.result {
        case .success(let data):
            print("response result : ", response.result)
            
            try Self.checkResultValidation(data.data)
            
            return data.data
        case .failure(let afError):
            throw afError
        }
    }
    
    fileprivate static func checkResultValidation(_ data : ResultPresentable) throws {
        guard let result = data.result else { return }
        
        guard result.isSuccess else {
            throw FncyWalletError(code: result.code,
                                  statusCode: result.number,
                                  message: result.message)
        }
    }
}
