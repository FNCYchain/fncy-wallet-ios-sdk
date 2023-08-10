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

public struct TicketData: Codable {
    public let resultType: String
    public let result: ResultInfo
    public let items: [FncyTicket]?
    public let web3Error: Web3Error?
    public let externalErrorMessage: String?
}

public struct Web3Error: Codable {
    public let data: String
    public let message: String
    public let code: Int
}

public struct FncyTicket: Codable {
    public let txInput: String
    public let transferVal: Decimal
    public let assetOrNftId: Int
    public let txGasPrice: Decimal
    public let txGasLimit: Decimal
    public let transferMethod: String
    public let transferTo: String
    public let wid: Int
    public let chainId: Int
    public let txNonce: Decimal
    public let sendTransferNotiYn: Bool
    public let nativeCoinId: Int
    public let maxFeePerGas: Decimal
    public let transferFrom: String
    public let maxPriorityPerGas: Decimal
    public let assetId: Int
    public let ticketUuid: String?
    public let signatureTypeDcd: TicketType?
    public let signatureType: String
    public let displayTransferValKrw: String?
    public let displayFeeKrw: String?
    public let ticketHash: String?
    public let displayFee: String?
    public let displayTransferVal: String?
    public let displayTransferValUsd: String?
    public let createKst: TimeInterval?
    public let createUts: TimeInterval?
    public let displayFeeUsd: String?
    public let nftId: Int?
    public let contractAddress: String?
    public let tokenId: Int?
    public let formerTicketUuid: String?
    public let walletSignature: String?
    public let contractParameters: String?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.txInput = try container.decode(String.self, forKey: .txInput)
        self.transferVal = try container.decode(Decimal.self, forKey: .transferVal)
        self.assetOrNftId = try container.decode(Int.self, forKey: .assetOrNftId)
        self.txGasPrice = try container.decode(Decimal.self, forKey: .txGasPrice)
        self.txGasLimit = try container.decode(Decimal.self, forKey: .txGasLimit)
        self.transferMethod = try container.decode(String.self, forKey: .transferMethod)
        self.transferTo = try container.decode(String.self, forKey: .transferTo)
        self.wid = try container.decode(Int.self, forKey: .wid)
        self.chainId = try container.decode(Int.self, forKey: .chainId)
        self.txNonce = try container.decode(Decimal.self, forKey: .txNonce)
        self.sendTransferNotiYn = try container.decodeIfPresent(String.self, forKey: .sendTransferNotiYn) == "Y"
        self.nativeCoinId = try container.decode(Int.self, forKey: .nativeCoinId)
        self.maxFeePerGas = try container.decode(Decimal.self, forKey: .maxFeePerGas)
        self.transferFrom = try container.decode(String.self, forKey: .transferFrom)
        self.maxPriorityPerGas = try container.decode(Decimal.self, forKey: .maxPriorityPerGas)
        self.assetId = try container.decode(Int.self, forKey: .assetId)
        self.ticketUuid = try container.decodeIfPresent(String.self, forKey: .ticketUuid)
        self.signatureTypeDcd = try container.decodeIfPresent(TicketType.self, forKey: .signatureTypeDcd)
        self.signatureType = try container.decode(String.self, forKey: .signatureType)
        self.displayTransferValKrw = try container.decodeIfPresent(String.self, forKey: .displayTransferValKrw)
        self.displayFeeKrw = try container.decodeIfPresent(String.self, forKey: .displayFeeKrw)
        self.ticketHash = try container.decodeIfPresent(String.self, forKey: .ticketHash)
        self.displayFee = try container.decodeIfPresent(String.self, forKey: .displayFee)
        self.displayTransferVal = try container.decodeIfPresent(String.self, forKey: .displayTransferVal)
        self.displayTransferValUsd = try container.decodeIfPresent(String.self, forKey: .displayTransferValUsd)
        self.createKst = try container.decodeIfPresent(TimeInterval.self, forKey: .createKst)
        self.createUts = try container.decodeIfPresent(TimeInterval.self, forKey: .createUts)
        self.displayFeeUsd = try container.decodeIfPresent(String.self, forKey: .displayFeeUsd)
        self.nftId = try container.decodeIfPresent(Int.self, forKey: .nftId)
        self.contractAddress = try container.decodeIfPresent(String.self, forKey: .contractAddress)
        self.tokenId = try container.decodeIfPresent(Int.self, forKey: .tokenId)
        self.formerTicketUuid = try container.decodeIfPresent(String.self, forKey: .formerTicketUuid)
        self.walletSignature = try container.decodeIfPresent(String.self, forKey: .walletSignature)
        self.contractParameters = try container.decodeIfPresent(String.self, forKey: .contractParameters)
    }
}

public struct MakeTicketResult: Codable {
    public let web3Error: Web3Error?
    public let ticketUuid: String?
    public let resultType: String
    public let result: ResultInfo?
    public let ticketHash: String
}
