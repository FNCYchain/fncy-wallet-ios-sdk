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

public class FncyWalletCore {
    private let authToken: String
    private let baseUrl: String

    public init(authToken: String) {
        self.authToken = authToken
        self.baseUrl = FncyWalletSDK.shared.baseURL()
    }
}

public extension FncyWalletCore {

    // MARK: - 회원
    // MARK: - 회원(회원추가)
    // 회원가입 및 로그인 시 마다 호출
    func insertUser() async throws -> ResultData {
        let urlString = self.baseUrl + "/v1/users"
        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .post)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // MARK: - 회원(기타)
    // 회원디바이스 토큰 삭제
    func logoutUser(_ uuid: String) async throws -> ResultData {
        let urlString = self.baseUrl + "/v1/users/user-devices/\(uuid)/token"
        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .delete)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    /// RSA public key 조회
    /// - ${baseUrl}/v1/users/rsa-public
    /// - get
    /// - Returns: String
    func getRSAKey() async throws -> String? {
        let urlString = self.baseUrl + "/v1/users/rsa-public"
        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        let result: PublicKeyData = try await WALLETAPI.request(apiRequest,
                                                                authToken: self.authToken)
        return result.userRsaPubKey
    }

    // MARK: - 블록체인
    // MARK: - 블록체인(플랫폼)
    // 블록체인 플랫폼 상세 조회
    func getBlockChainInfo(chainID: Int) async throws -> FncyChainInfo? {
        let urlString = self.baseUrl + "/v1/block-chains/\(chainID)"
        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        let result: ListData<[FncyChainInfo]> = try await WALLETAPI.request(apiRequest,
                                                                            authToken: self.authToken)
        return result.items?.first
    }

    // 블록체인 플랫폼 자산 목록
    func getAvailableTokens(chainID: Int) async throws -> PagingListData<[FncyAssetInfo]> {
        let urlString = self.baseUrl + "/v1/block-chains/\(chainID)/assets"
        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // 블록체인 플랫폼 자산 contract
    func getContractInfo(chainID: Int,
                         contractAddress: String) async throws -> ListData<[ContractInfo]> {
        let urlString = self.baseUrl + "/v1/block-chains/\(chainID)/assets/contractAddress/\(contractAddress)"
        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // 블록체인 플랫폼 NFT 목록
    func getNFTItemList(chainID: Int) async throws -> PagingListData<[NFTItemInfo]> {
        let urlString = self.baseUrl + "/v1/block-chains/\(chainID)/nfts"
        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // MARK: - 블록체인(시세)
    // Fncy 정보 조회
    func getFncyInfo() async throws -> ListData<[FncyInfo]> {
        let urlString = self.baseUrl + "/v1/block-chains/fncy-info"
        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // MARK: - 블록체인(기타)
    // 주소 유효성 조회
    func validateAddress(chainID: Int,
                         address: String) async throws -> Bool {
        let urlString = self.baseUrl + "/v1/block-chains/\(chainID)/address/\(address)/valid"
        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        let result : AddressValidationResult = try await WALLETAPI.request(apiRequest,
                                                                           authToken: self.authToken)
        return result.isValid
    }

    // 가스비 조회
    func getGasPrice(chainID: Int) async throws -> GasPriceInfo? {
        let urlString = self.baseUrl + "/v1/block-chains/\(chainID)/gas-price"
        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        let result: ListData<[GasPriceInfo]> = try await WALLETAPI.request(apiRequest,
                                                                           authToken: self.authToken)
        return result.items?.first
    }

    // MARK: - 지갑
    // MARK: - 지갑(지갑 만들기)
    // 지갑 생성
    // MARK: 지갑 생성(파라미터체크)✅
    func makeWallet(walletNm: String,
                    pinNumber: String) async throws -> WalletMakeResultData {

        try FncyUtil.pinStringValidationCheck(pinNumber)

        guard let rsaPublicKey = try await self.getRSAKey() else {
            throw FncyWalletError.someError
        }

        let rsaEncryptUserPin = try pinNumber.data.sha256().toHexString().encryptRSA(rsaPublicKey)

        let urlString = self.baseUrl + "/v2/wallets"

        // chainID : 1을 그냥 넣고 있는데, 이 필드가 의미가 있는가??
        let parameters: [String: Any] = ["chainId": 1,
                                           "walletNm": walletNm,
                                           "rsaEncryptUserPin": rsaEncryptUserPin]

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .post,
                                    parameters: parameters)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // 지갑 복원 키 추가
    // MARK: 지갑 복원 키 추가(파라미터체크)✅
    func postRegisterRestorationKey(wid: Int,
                                    questionSeq: Int,
                                    answer: String,
                                    pinNumber: String) async throws -> ResultData {
        guard let rsaPublicKey = try await self.getRSAKey() else {
            throw FncyWalletError.someError
        }
        let rsaEncryptUserQuestion = try String(questionSeq).data.sha256()
            .toHexString().encryptRSA(rsaPublicKey)

        let rsaEncryptUserAnswer = try answer.data.sha256().toHexString().encryptRSA(rsaPublicKey)

        let rsaEncryptUserPin = try pinNumber.data.sha256().toHexString().encryptRSA(rsaPublicKey)

        let urlString = "\(self.baseUrl)/v2/wallets/\(wid)/restore"

        let params: [String: Any] = ["rsaEncryptUserQuestion": rsaEncryptUserQuestion,
                                      "rsaEncryptUserAnswer": rsaEncryptUserAnswer,
                                      "rsaEncryptUserPin": rsaEncryptUserPin]

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .post,
                                    parameters: params)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // 지갑 비밀번호 확인
    func checkWalletPin(pinNumber: String,
                        excludeHistoryYn: Bool = false) async throws -> ResultData {

        try FncyUtil.pinStringValidationCheck(pinNumber)

        guard let rsaPublicKey = try await self.getRSAKey() else {
            throw FncyWalletError.someError
        }

        let urlString = self.baseUrl + "/v1/wallets/pin-check?excludeHistoryYn=\(excludeHistoryYn ? "Y" : "N")"

        let hashedString = pinNumber.data.sha256().sha256().toHexString()

        let parameters: [String: Any] = ["rsaEncryptedHashedPin": try hashedString.encryptRSA(rsaPublicKey)]

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .post,
                                    parameters: parameters)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // 지갑 생성 - 복원용 질문 목록
    // MARK: 파라미터OK💠
    func getQuestionList(pageNo: Int = 1,
                         pageSize: Int = 20) async throws -> PagingListData<[FncyQuestion]> {
        let urlString = "\(self.baseUrl)/v1/questions"

        let params: [String: Any] = ["pageNo": pageNo,
                                     "pageSize": pageSize]

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .post,
                                    parameters: params)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // 지갑 복구 질문답변 확인
    func checkResetAnswer(answer: String) async throws -> ResultData {

        guard let rsaPublicKey = try await self.getRSAKey() else {
            throw FncyWalletError.someError
        }

        let rsaEncryptedHashedAnswer = try answer.lowercased()
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\r", with: "").data.sha256().sha256().toHexString().encryptRSA(rsaPublicKey)

        let rsaEncryptedHashedAnswerAlter = try answer.data.sha256().sha256().toHexString().encryptRSA(rsaPublicKey)

        let urlString = self.baseUrl + "/v1/wallets/answer-check"

        let params = ["rsaEncryptedHashedAnswer": rsaEncryptedHashedAnswer,
                      "rsaEncryptedHashedAnswerAlter": rsaEncryptedHashedAnswerAlter]

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .post,
                                    parameters: params)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // MARK: - 지갑(지갑 수정)
    // MARK: 파라미터OK💠
    func resetWalletPin(oldPinNumber: String,
                        newPinNumber: String) async throws -> ResultData {

        try FncyUtil.pinStringValidationCheck(oldPinNumber)
        try FncyUtil.pinStringValidationCheck(newPinNumber)

        guard let rsaPublicKey = try await self.getRSAKey() else {
            throw FncyWalletError.someError
        }

        let rsaEncryptUserPin = try oldPinNumber.data.sha256().toHexString().encryptRSA(rsaPublicKey)

        let rsaEncryptChangeUserPin = try newPinNumber.data.sha256().toHexString().encryptRSA(rsaPublicKey)

        let urlString = self.baseUrl + "/v1/wallets/pin"

        let params = ["rsaEncryptUserPin": rsaEncryptUserPin,
                      "rsaEncryptChangeUserPin": rsaEncryptChangeUserPin,
                      "simplePinYn": "Y"]

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .patch,
                                    parameters: params)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // 지갑 복원 - 사용자 선택 질문
    // MARK: 파라미터OK💠
    func getResetQuestion() async throws -> FncyQuestion? {
        let urlString = self.baseUrl + "/v1/wallets/restore/questions"

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        let result: ListData<[FncyQuestion]> = try await WALLETAPI.request(apiRequest,
                                                                           authToken: self.authToken)
        return result.items?.first
    }

    // 지갑 복원 - 질문 답변
    // MARK: 파라미터OK💠
    func postResetQuestion(answer: String,
                           newPinNumber: String) async throws -> ResultData {

        try FncyUtil.pinStringValidationCheck(newPinNumber)

        guard let rsaPublicKey = try await self.getRSAKey() else {
            throw FncyWalletError.someError
        }

        let rsaEncryptUserAnswer = try answer.data.sha256().toHexString().encryptRSA(rsaPublicKey)

        let rsaEncryptChangeUserPin = try newPinNumber.data.sha256().toHexString().encryptRSA(rsaPublicKey)

        let urlString = self.baseUrl + "/v1/wallets/restore/answer"

        let parameters: [String: Any] = ["rsaEncryptUserAnswer": rsaEncryptUserAnswer,
                                          "rsaEncryptChangeUserPin": rsaEncryptChangeUserPin,
                                          "simplePinYn": "Y"]

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .patch,
                                    parameters: parameters)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // MARK: - 지갑(지갑 조회)
    // 지갑 목록 조회
    // MARK: 파라미터OK💠
    func getWallet() async throws -> FncyWallet? {
        let urlString = self.baseUrl + "/v1/wallets"

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        let result: ListData<[FncyWallet]> = try await WALLETAPI.request(apiRequest,
                                                                         authToken: self.authToken)
        return result.items?.first
    }

    // 지갑 총 자산 조회
    // MARK: 파라미터OK💠
    func getWalletAllBalance(wid: Int) async throws -> FncyBalance? {
        let urlString = self.baseUrl + "/v1/wallets/\(wid)/balance"

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        let result: ListData<[FncyBalance]> = try await WALLETAPI.request(apiRequest,
                                                                          authToken: self.authToken)
        return result.items?.first
    }

    // 지갑 - 자산 목록 조회
    // MARK: 파라미터OK💠
    func getAssetList(wid: Int) async throws -> PagingListData<[FncyAsset]> {
        let urlString = self.baseUrl + "/v1/wallets/\(wid)/assets-all"

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // 지갑 - 자산 단 건 조회
    // MARK: 파라미터OK💠
    func getAssetById(wid: Int,
                      assetId: Int) async throws -> FncyAsset? {
        let urlString = self.baseUrl + "/v1/wallets/\(wid)/assets/\(assetId)"

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        let result: ListData<[FncyAsset]> = try await WALLETAPI.request(apiRequest,
                                                                        authToken: self.authToken)
        return result.items?.first
    }

    // 지갑 - NFT 목록 조회
    // MARK: 파라미터OK💠
    func getNFTList(wid: Int,
                    pageNo: Int = 1,
                    pageSize: Int = 6) async throws -> PagingListData<[FncyNFT]> {
        let urlString = self.baseUrl + "/v1/wallets/\(wid)/nfts"

        // let parameter
        let params = ["pageNo": pageNo,
                      "pageSize": pageSize]

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get,
                                    parameters: params)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // 지갑 - NFT 단 건 조회
    // MARK: 파라미터OK💠
    func getNFTById(wid: Int,
                    nftId: Int) async throws -> FncyNFT? {

        let urlString = self.baseUrl + "/v1/wallets/\(wid)/nfts/\(nftId)"

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        let result: ListData<[FncyNFT]> = try await WALLETAPI.request(apiRequest,
                                                                      authToken: self.authToken)
        return result.items?.first
    }

    // MARK: - 트랜잭션
    // MARK: - 트랜잭션(트랜잭션 생성)

    // 전송 티켓 확인
    func estimateTicket(_ walletId: Int,
                        chainId: Int,
                        signatureType: TicketType,
                        toAddress: String,
                        transferVal: String? = nil,
                        transferMethod: String? = nil,
                        // txGasPrice: String? = nil,
                        txInput: String? = nil,
                        contractAddress: String? = nil,
                        assetId: Int? = nil,
                        nftId: Int? = nil,
                        maxPriorityPerGas: String? = nil,
                        maxFeePerGas: String? = nil) async throws -> TicketData {

        let urlString = self.baseUrl + "/v2/transfers/estimate"
        var parameters: [String: Any] = ["chainId": chainId,
                                          "wid": walletId,
                                          "signatureType": signatureType.id,
                                          "transferTo": toAddress]

        if let transferVal = transferVal { parameters["transferVal"] = transferVal }
        if let transferMethod = transferMethod { parameters["transferMethod"] = transferMethod }
        if let contractAddress = contractAddress { parameters["contractAddress"] = contractAddress }
        if let assetId = assetId { parameters["assetId"] = assetId }
        if let nftId = nftId { parameters["nftId"] = nftId }
        if let maxPriorityPerGas = maxPriorityPerGas { parameters["maxPriorityPerGas"] = maxPriorityPerGas }
        if let maxFeePerGas = maxFeePerGas { parameters["maxFeePerGas"] = maxFeePerGas }
        if let txInput = txInput { parameters["txInput"] = txInput.addHexPrefix() }

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .post,
                                    parameters: parameters)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // 전송 티켓 생성
    func makeTicket(_ wid: Int,
                    signatureType: TicketType,
                    toAddress: String,
                    transferVal: String,
                    txGasPrice: String? = nil,
                    txInput: String? = nil,
                    contractAddress: String? = nil,
                    assetId: Int? = nil,
                    nftId: Int? = nil,
                    tokenId: Int? = nil,
                    chainId: Int,
                    maxPriorityPerGas: String? = nil,
                    maxFeePerGas: String? = nil,
                    txGasLimit: String? = nil) async throws -> MakeTicketResult {
        let urlString = "\(self.baseUrl)/v2/transfers/tickets"

        var parameters: [String: Any] = ["chainId": chainId,
                                          "wid": wid,
                                          "signatureType": signatureType.id,
                                          "transferTo": toAddress,
                                          "transferVal": transferVal]

        if let contractAddress = contractAddress { parameters["contractAddress"] = contractAddress }
        if let assetId = assetId { parameters["assetId"] = assetId }
        if let nftId = nftId { parameters["nftId"] = nftId }
        if let maxPriorityPerGas = maxPriorityPerGas { parameters["maxPriorityPerGas"] = maxPriorityPerGas }
        if let maxFeePerGas = maxFeePerGas { parameters["maxFeePerGas"] = maxFeePerGas }
        if let txGasPrice = txGasPrice { parameters["txGasPrice"] = txGasPrice }
        if let txGasLimit = txGasLimit { parameters["txGasLimit"] = txGasLimit }
        if let txInput = txInput { parameters["txInput"] = txInput.addHexPrefix() }

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .post,
                                    parameters: parameters)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // 트랜잭션 전송
    func sendTransaction(ticketUuid: String,
                         pinNumber: String) async throws -> TicketData {

        guard let rsaPublicKey = try await self.getRSAKey() else {
            throw FncyWalletError.someError
        }

        let rsaEncryptedHashedPin = try pinNumber.data.sha256().toHexString().encryptRSA(rsaPublicKey)

        let urlString = "\(self.baseUrl)/v1/transfers/tickets/\(ticketUuid)"

        let parameters: [String: Any] = ["rsaEncryptedHashedPin": rsaEncryptedHashedPin]

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get,
                                    parameters: parameters)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // 전송 티켓 조회
    func getTicketInfo(ticketUUID: String) async throws -> TicketData {
        let urlString = "\(self.baseUrl)/v1/transfers/tickets/\(ticketUUID)"

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // MARK: - 트랜잭션(트랜잭션 조회)
    // 최근 출금 목록 조회
    func getRecentAddress(wid: Int,
                          limit: Int = 5) async throws -> [FncyTransaction] {
        let urlString = "\(self.baseUrl)/v1/wallets/\(wid)/assets/transfers/recent?limit=\(limit)"

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)

        let result: ListData<[FncyTransaction]> = try await WALLETAPI.request(apiRequest,
                                                                               authToken: self.authToken)
        return result.items ?? []
    }

    // 자산 전송 히스토리 목록 조회
    func getTransferHistoryList(wid: Int,
                                assetId: Int,
                                pageNo: Int = 1,
                                pageSize: Int = 6,
                                filter: InOutDcd = .all) async throws -> PagingListData<[FncyTransaction]> {
        let urlString = "\(self.baseUrl)/v1/wallets/\(wid)/assets/transfers"

        var parameters: [String: Any] = ["assetId": assetId,
                                         "pageNo": pageNo,
                                         "pageSize": pageSize]
        
        if let inOutId = filter.id {
            parameters["inOut"] = inOutId
        }
        
        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get,
                                    parameters: parameters)
        return try await WALLETAPI.request(apiRequest,
                                           authToken: self.authToken)
    }

    // ERC20 자산 전송 히스토리 상세
    func getTransferHistoryDetail(wid: Int,
                                  historySeq: Int) async throws -> FncyTransaction? {
        let urlString = "\(self.baseUrl)/v2/wallets/\(wid)/assets/transfers/\(historySeq)"
        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .get)
        
        let result: ListData<[FncyTransaction]> = try await WALLETAPI.request(apiRequest,
                                                                              authToken: self.authToken)
        
        return result.items?.first
    }

    // MARK: - 트랜잭션(기타)
    // 지갑 서명
    // MARK: ✅
    func postWalletSign(wid: Int,
                        dataToSign: String,
                        signType: String? = nil,
                        userWalletPin: String) async throws -> String? {

        guard let rsaPublicKey = try await self.getRSAKey() else {
            throw FncyWalletError.someError
        }

        let rsaEncryptedHashedPin = try userWalletPin.data.sha256().toHexString().encryptRSA(rsaPublicKey)

        let urlString = "\(self.baseUrl)/v1/wallets/\(wid)/signature"

        var params = ["dataToSign": dataToSign,
                      "rsaEncryptedHashedPin": rsaEncryptedHashedPin]

        if let signType = signType { params["signType"] = signType }

        let apiRequest = APIRequest(requestUrl: urlString,
                                    method: .post,
                                    parameters: params)

        let result: ListData<EmptyType> = try await WALLETAPI.request(apiRequest,
                                                                      authToken: self.authToken)
        return result.signature
    }
}
