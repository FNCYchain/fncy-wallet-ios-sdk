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
    // 클라이언트 측 오류
    case clientFailed(reason: ClientFailureReason,
                      errorMessage: String?)
    // 서버 응답 오류
    case apiFailed(code: String,
                   apiStatusCode: Int,
                   errorMessage: String,
                   apiRequest: APIRequest,
                   web3Error: Web3Error?)
    // 응답 데이터가 유효하지 않음
    case invalidDataError(reason: FncyDataErrorReason,
                          errorMessage: String?)
}

extension FncyWalletError {
    internal init(reason: ClientFailureReason = .unknown, message: String? = nil) {
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

extension FncyWalletError : CustomStringConvertible {
    public var description: String {
        switch self {
        case .clientFailed(let reason, let errorMessage):
            return String(format: "🚫[FncyWallet ClientError Occur]\n-reason: %@\n-message: %@\n", reason.description, errorMessage ?? "")
            
        case .apiFailed(let code, let statusCode, let errorMessage, let apiRequest, let web3Error):
            guard let web3Error = web3Error else {
                return String(format: "🚫[FncyWallet APIError Occur]\n-ErrorCode: %@\n-StatusCode: %d\n-message: %@\n%@\n", code, statusCode, errorMessage, String(describing: apiRequest))
            }
            return String(format: "🚫[FncyWallet APIError Occur]\n-ErrorCode: %@\n-StatusCode: %d\n-message: %@\n-web3error:%@\n%@\n", code, statusCode, errorMessage,  String(describing: web3Error), String(describing: apiRequest))
            
        case .invalidDataError(let reason, let errorMessage):
            return String(format: "🚫[FncyWallet DataError Occur]\n-reason:[%@]\n-message:%@\n", reason.description, errorMessage ?? "")
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

extension ClientFailureReason : CustomStringConvertible {
    public var description: String {
        switch self {
        case .mustInitApiKey:
            return "MUST_INIT_API_KEY"
        case .tokenNotFound:
            return "TOKEN_NOT_FOUND"
        case .invalidCharactersAreIncluded:
            return "INVALID_CHARACTERS_ARE_INCLUDED"
        case .pinStringIsTooLong:
            return "PIN_STRING_IS_TOO_LONG"
        case .unknown:
            return "UNKNOWN_CLIENT_ERROR"
        }
    }
}


extension FncyWalletError {
    internal init(code: String,
                  statusCode: Int,
                  message: String,
                  apiRequest: APIRequest,
                  web3Error: Web3Error?) {
        self = .apiFailed(code: code,
                          apiStatusCode: statusCode,
                          errorMessage: message,
                          apiRequest: apiRequest,
                          web3Error: web3Error)
    }
}


public enum FncyDataErrorReason {
    // RSA Public Key가 유효하지 않음
    case missingRsaPublickKey
    // Signature가 nil 이거나 빈 문자열
    case emptySignature
    // 네트워크의 GasPriceInfo를 획득하지 못함
    case emptyGasPriceInfo
    // 아직 보유한 지갑이 없습니다
    case notFoundFncyWallet
    // 총 자산 정보가 비어있음
    case notFoundBalanceInfo
    // 저장된 지갑 복구용 질문이 없습니다.
    case notFoundResetQuestion
    // ID로 자산을 조회할 수 없습니다.
    case noAssetFoundByID
    // 해당 SequenceID로 트랜잭션 기록을 조회 할 수 없습니다.
    case noTransactionHistoryBySequenceID
    // 컨트랙트 정보를 조회할 수 없습니다.
    case noFoundContractInfo
    // Fncy 시세 정보를 가져오지 못함
    case noFoundFncyInfo
    // TicketID로 Ticket정보를 찾지 못함
    case noTicketDataFoundbyTicketID
    // EstimateTicket 결과가 없음
    case missingEstimateResult
    // TxID 가 누락됨
    case missingTxID
    // TicketUUID 가 누락됨
    case missingTicketUUID
    // FncyInfo 누락
    case missingFncyInfo
    // FncyChainInfo 누락
    case missingFncyChainInfo
}

extension FncyDataErrorReason : CustomStringConvertible {
    public var description: String {
        switch self {
        case .emptySignature:
            return "EmptySignature"
        case .missingRsaPublickKey:
            return "MissingRSAPublicKey"
        case .emptyGasPriceInfo:
            return "EmptyGasPriceInfo"
        case .notFoundFncyWallet:
            return "NotFoundFncyWallet"
        case .notFoundBalanceInfo:
            return "NotFoundBalanceInfo"
        case .notFoundResetQuestion:
            return "NotFoundResetQuestion"
        case .noAssetFoundByID:
            return "NoAssetFoundByID"
        case .noTransactionHistoryBySequenceID:
            return "NoTransactionHistoryBySequenceID"
        case .noFoundContractInfo:
            return "NoFoundContractInfo"
        case .noFoundFncyInfo:
            return "NoFoundFncyInfo"
        case .noTicketDataFoundbyTicketID:
            return "NoTicketDataFound"
        case .missingEstimateResult:
            return "MissingEstimateResult"
        case .missingTxID:
            return "MissingTxID"
        case .missingTicketUUID:
            return "MissingTicketUUID"
        case .missingFncyInfo:
            return "MissingFncyInfo"
        case .missingFncyChainInfo:
            return "MissingFncyChainInfo"
        }
    }
}

public extension FncyWalletError {
    internal init(reason : FncyDataErrorReason) {
        switch reason {
        case .missingRsaPublickKey:
            self = .invalidDataError(reason: reason, errorMessage: "RSA Public Key is nil or empty. Please check your authorization Token.")
        case .emptySignature:
            self = .invalidDataError(reason: reason, errorMessage: "Signature is nil or empty. Please check your authorization Token & pin number string.")
        case .emptyGasPriceInfo:
            self = .invalidDataError(reason: reason, errorMessage: "Not found GasPriceInfo. Please check chainId of parameter.")
        case .notFoundFncyWallet:
            self = .invalidDataError(reason: reason, errorMessage: "Not found Wallet. Please make Wallet first.")
        case .notFoundBalanceInfo:
            self = .invalidDataError(reason: reason, errorMessage: "Not found Total Balance Info.")
        case .notFoundResetQuestion:
            self = .invalidDataError(reason: reason, errorMessage: "Not found Reset Question.")
        case .noAssetFoundByID:
            self = .invalidDataError(reason: reason, errorMessage: "No asset found for ID.")
        case .noTransactionHistoryBySequenceID:
            self = .invalidDataError(reason: reason, errorMessage: "No Transaction History found for History Sequence Id.")
        case .noFoundContractInfo:
            self = .invalidDataError(reason: reason, errorMessage: "No Smart Contract Info found for NetworkID and Contract Address.")
        case .noFoundFncyInfo:
            self = .invalidDataError(reason: reason, errorMessage: "No Found Fncy Info.")
        case .noTicketDataFoundbyTicketID:
            self = .invalidDataError(reason: reason, errorMessage: "No TicketData Found for TicketUUID.")
        case .missingEstimateResult:
            self = .invalidDataError(reason: reason, errorMessage: "No TicketData Found for 'Estimate Ticket Result'.")
        case . missingTxID:
            self = .invalidDataError(reason: reason, errorMessage: "txID not found.")
        case .missingTicketUUID:
            self = .invalidDataError(reason: reason, errorMessage: "ticketUUID not found.")
        case .missingFncyInfo:
            self = .invalidDataError(reason: reason, errorMessage: "FncyCurrencyInfo not found.")
        case .missingFncyChainInfo:
            self = .invalidDataError(reason: reason, errorMessage: "ChainInfo not found. Please check chain ID.")
        }
    }
}

public enum Web3ErrorReason {
    
}
