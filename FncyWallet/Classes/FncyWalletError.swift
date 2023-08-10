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

public enum FncyWalletError: Error {
    case clientFailed(reason: ClientFailureReason, errorMessage: String?)
    case someError
    // 1. failToGetRSAKey RSAKey가 오염되었거나, 서버에서 잘못된 응답을 보내고있을 경우
}

extension FncyWalletError {
    public init(reason: ClientFailureReason = .unknown, message: String? = nil) {
        switch reason {
        case .mustInitApiKey:
            self = .clientFailed(reason: reason, errorMessage: "initSDK(apiKey:) must be initialized.")
        case .tokenNotFound:
            self = .clientFailed(reason: reason, errorMessage: message ?? "authentication tokens not exist.")
        case .invalidCharactersAreIncluded, .pinStringIsTooLong:
            self = .clientFailed(reason: reason,
                                 errorMessage: "Please enter the PIN number as a 6-digit string of 0-9.")
        case .unknown:
            self = .clientFailed(reason: reason, errorMessage: message ?? "unknown error.")
        }
    }
}

public enum ClientFailureReason {
    /// SDK 초기화를 하지 않음
    case mustInitApiKey
    /// API 요청에 사용할 토큰이 없음
    case tokenNotFound
    /// 입력한 핀번호가 핀번호 규칙과 일치하지 않음
    case invalidCharactersAreIncluded
    /// 등록하려는 핀번호는 숫자 6자리 고정
    case pinStringIsTooLong
    /// 알 수 없는 에러
    case unknown
}
