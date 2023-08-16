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
    case apiFailed(reason: ApiFailureReason,
                   apiStatusCode: Int,
                   errorMessage: String)
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
            return String(format: "[ClientError]: %@ \n%@", reason.description, errorMessage ?? "")
            
        case .apiFailed(let reason, let code, let errorMessage):
            return String(format: "[WalletAPI Error(%d)]: %@ \n%@", code, reason.rawValue, errorMessage)
            
        case .invalidDataError(let reason, let errorMessage):
            return String(format: "[Data Error] %@ : %@", reason.description, errorMessage ?? "")
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
    internal init(reason: ApiFailureReason = .unknown,
                  code: Int = -9999,
                  message: String) {
        self = .apiFailed(reason: reason,
                          apiStatusCode: code,
                          errorMessage: message)
    }
}


public enum ApiFailureReason : String, Codable {
    /// -9999, UNKNOWN
    case unknown = "UNKNOWN"
    /// 200, "SUCCESS"
    case success = "SUCCESS"
    /// System Error
    case error = "ERROR"
    /// 404, "존재하지 않는 UUID"
    case notFoundUuid = "NOT_FOUND_UUID"
    /// 202, "ACCEPTED: 이미 동기화 되어있는 FID"
    case accepted = "ACCEPTED"
    /// 400, BAD_REQUEST: 유효하지 않은 FID
    case invalidFid = "INVALID_FID"
    /// 403, FORBIDDEN: 기등록 사용자
    case registeredUser = "REGISTERED_USER"
    /// 403, "FORBIDDEN: 이미 지갑을 등록한 사용자"
    case registeredUserWallet = "REGISTERED_USER_WALLET"
    /// 403, FORBIDDEN: 질문 답변이 일치하지 않음
    case missMatchUserAnswer = "MISS_MATCH_USER_ANSWER"
    /// 400,  "BAD_REQUEST: TRANSFER_TO 누락"
    case emptyTransferTo = "EMPTY_TRANSFER_TO"
    /// 400,  "BAD_REQUEST: SIGNATURE_TYPE_FOR_ASSET_TRANSFER 는 ASSET_ID, NFT_ID 중 한 필드만 필요함"
    case transferNeedAssetOrNFT = "TRANSFER_NEED_ASSET_OR_NFT"
    /// 301, "FAIL: 티켓 생성 실패"
    case ticketCreateFail = "TICKET_CREATE_FAIL"
    /// 403, "FORBIDDEN: 티켓이 만료됨 (생성 후 5분 경과)"
    case ticketExpired = "TICKET_EXPIRED"
    /// 200, "SUCCESS: 티켓 전송이 가능한 상태"
    case transferAvailable = "TRANSFER_AVAILABLE"
    /// 404, NOT_FOUND: 존재하지 않는 사용자 지갑
    case unregisteredUserWallet = "UNREGISTERED_USER_WALLET"
    /// 403, FORBIDDEN: 이미 생성된 Transfer Ticket Data
    case registeredTransferNonce = "REGISTERED_TRANSFER_NONCE"
    /// 404, NOT_FOUND: 존재하지 않는 티켓
    case notExistTicket = "NOT_EXIST_TICKET"
    /// 301, FAIL: 트랜잭션 서명 실패
    case failSignTransaction = "FAIL_SIGN_TRANSACTION"
    /// 400, BAD_REQUEST: SIGNATURE_TICKET 누락
    case emptyTicket = "EMPTY_TICKET"
    /// 401, UNAUTHORIZED: SIGNATURE_TICKET 일치하지 않음
    case wrongTicket = "WRONG_TICKET"
    /// 401, UNAUTHORIZED: PIN 일치하지 않음
    case wrongPin = "WRONG_PIN"
    /// 403, FORBIDDEN: 연속된 NONCE 가 아니기 때문에 연사 트랜잭션 불가, 티켓 재발행 필요
    case notContinuousNonce = "NOT_CONTINUOUS_NONCE"
    /// 301, FAIL: 트랜잭션 전송 실패
    case failSendTransaction = "FAIL_SEND_TRANSACTION"
    /// 401, UNAUTHORIZED: 지갑 SECURE_LEVEL 이 낮음 (복원키 등록 필요)
    case lowWalletSecureLevel = "LOW_WALLET_SECURE_LEVEL"
    /// 404, NOT_FOUND: 존재하지 않거나 소유자가 다른 지갑
    case notExistWallet = "NOT_EXIST_WALLET"
    /// 403, FORBIDDEN: 이전 티켓이 유효하지 않음
    case wrongFormerTicket = "WRONG_FORMER_TICKET"
    /// 403, FORBIDDEN: 유효하지 않은 서명 타입
    case wrongSignatureType = "WRONG_SIGNATURE_TYPE"
    /// 400, BAD_REQUEST: TRANSFER_VAL 누락
    case emptyTransferVal = "EMPTY_TRANSFER_VAL"
    /// 400, BAD_REQUEST: TX_NONCE 누락
    case emptyTxNonce = "EMPTY_TX_NONCE"
    /// 400, BAD_REQUEST: TX_GAS_PRICE 누락
    case emptyTxGasPrice = "EMPTY_TX_GAS_PRICE"
    /// 400, BAD_REQUEST: TX_GAS_LIMIT
    case emptyTxGasLimit = "EMPTY_TX_GAS_LIMIT"
    /// 400, BAD_REQUEST: TX_INPUT 누락
    case emptyTxInput = "EMPTY_TX_INPUT"
    /// 400, BAD_REQUEST: 잘못된 CHAIN_ID
    case wrongChainId = "WRONG_CHAIN_ID"
    /// 400, BAD_REQUEST: CONTRACT_ADDRESS 누락
    case emptyContractAddress = "EMPTY_CONTRACT_ADDRESS"
    /// 404, NOT_FOUND: 등록되어 있지 않은 체인 아이디
    case unregisteredChainID = "UNREGISTERED_CHAIN_ID"
    /// 403, BAD_REQUEST:  토큰 컨트랙트 주소 필요
    case requiredTokenContractAddress = "REQUIRED_TOKEN_CONTRACT_ADDRESS"
    /// 400, BAD_REQUEST: UUID 필요
    case requiredUuid = "REQUIRED_UUID"
    /// 400, BAD_REQUEST: FID 필요
    case requiredFid = "REQUIRED_FID"
    /// 403, ALREADY_EXISTS_UUID: 이미 존재하는 UUID
    case alreadyExistsUuid = "ALREADY_EXISTS_UUID"
    /// 403, ALREADY_EXISTS: 이미 등록되어있는 기기
    case alreadyExistsDevice = "ALREADY_EXISTS_DEVICE"
    /// 404, NOT_FOUND: 존재하지 않는 FID
    case notFoundFid = "NOT_FOUND_FID"
    /// 400, BAD_REQUEST: 필수값(비밀번호) 누락
    case requiredUserPin = "REQUIRED_USER_PIN"
    /// 404, BAD_REQUEST: 필수값(질문답변) 누락
    case requiredUserAnswer = "REQUIRED_USER_ANSWER"
    /// 404, NOT_FOUND: 등록되어 있지 않은 사용자
    case unregisteredUser = "UNREGISTERED_USER"
    /// 404, NOT_FOUND: 생성한 지갑이 존재하지 않음
    case unregisteredWallet = "UNREGISTERED_WALLET"
    /// 403, FORBIDDEN: 비밀번호가 일치하지 않음
    case missMatchUserWalletPin = "MISS_MATCH_USER_WALLET_PIN"
    /// 403, FORBIDDEN: 비밀번호를 많이 틀림
    case tooManyWrongPin = "TOO_MANY_WRONG_PIN"
    /// 401, authentication failed
    case unauthorized = "UNAUTHORIZED"
    /// 403, FORBIDDEN: 지갑 복구 답변 불일치, Key Chain 조회 불가
    case missMatchUserRestoreAnswer = "MISS_MATCH_USER_RESTORE_ANSWER"
}







public enum FncyDataErrorReason {
    // RSA Public Key가 유효하지 않음
    case missingRsaPublickKey
    // Signature가 nil 이거나 빈 문자열
    case emptySignature
    // 네트워크의 GasPriceInfo를 획득하지 못함
    case emptyGasPriceInfo
}

extension FncyDataErrorReason : CustomStringConvertible {
    public var description: String {
        switch self {
        case .emptySignature:
            return "Empty Signature"
        case .missingRsaPublickKey:
            return "Fail to get 'RSA Public Key'"
        case .emptyGasPriceInfo:
            return "Empty 'Gas Price Info'"
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
            self = .invalidDataError(reason: reason, errorMessage: "Not found GasPriceInfo. Please check chainId of parameter")
            
        }
    }
}

public enum Web3ErrorReason {
    
}
