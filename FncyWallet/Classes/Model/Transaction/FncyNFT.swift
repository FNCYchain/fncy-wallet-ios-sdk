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

public struct FncyNFT: Codable {
    public let nftId: Int
    public let wid: Int?
    public let nftOrd: Int?
    public let ownerOfDcd: OwnerOfDcd
    public let ownerOf: String
    public let displayYn: Bool?
    public let lockedYn: Bool
    public let nftInfo: NFTInfo
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nftInfo = try container.decode(NFTInfo.self, forKey: .nftInfo)
        self.ownerOf = try container.decode(String.self, forKey: .ownerOf)
        self.displayYn = try container.decodeIfPresent(String.self, forKey: .displayYn) == "Y"
        self.lockedYn = try container.decode(String.self, forKey: .lockedYn) == "Y"
        self.nftOrd = try container.decodeIfPresent(Int.self, forKey: .nftOrd)
        self.nftId = try container.decode(Int.self, forKey: .nftId)
        self.ownerOfDcd = try container.decode(OwnerOfDcd.self, forKey: .ownerOfDcd)
        self.wid = try container.decodeIfPresent(Int.self, forKey: .wid)
    }
}

public struct NFTInfo: Codable {
    public let nftId: Int?
    public let nftNm: String
    public let chainId: Int
    public let tokenId: String
    public let contractAddress: String
    public let nftDesc: String?
    public let gameCode: String?
    public let marketId: String?
    public let attributes: [String]?
    public let nftMetaInfo: NFTMetaInfo?
    public let nftSymbol: String
    public let nftSymbolImg: String
    public let assetTypeDcd: AssetTypeDcd
    public let assetType: String
    public let nftTypeDcd: NFTType
    public let nftMetaUri: String
    public let nftDirectLink: String?
    public let nftHolderAuthDirectLink: String?
    public let nftAnimationUrl: String?
    public let nftMediaUri: String?
    public let nftMetaJson: String?
    public let retryCount: Int?
    public let btnNftcancelYn: Bool
    public let btnNftmodifyYn: Bool
    public let finalizedYn: Bool?
    public let binanceSaleYn: Bool
    public let btnSendtogameYn: Bool
    public let btnNftsellYn: Bool
    public let holderAuthYn: Bool
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nftId = try container.decodeIfPresent(Int.self, forKey: .nftId)
        self.nftNm = try container.decode(String.self, forKey: .nftNm)
        self.chainId = try container.decode(Int.self, forKey: .chainId)
        self.tokenId = try container.decode(String.self, forKey: .tokenId)
        self.contractAddress = try container.decode(String.self, forKey: .contractAddress)
        self.nftDesc = try container.decodeIfPresent(String.self, forKey: .nftDesc)
        self.gameCode = try container.decodeIfPresent(String.self, forKey: .gameCode)
        self.marketId = try container.decodeIfPresent(String.self, forKey: .marketId)
        
        self.attributes = try container.decodeIfPresent([String].self, forKey: .attributes)
        self.nftMetaInfo = try container.decodeIfPresent(NFTMetaInfo.self, forKey: .nftMetaInfo)
        self.nftSymbol = try container.decode(String.self, forKey: .nftSymbol)
        self.nftSymbolImg = try container.decode(String.self, forKey: .nftSymbolImg)
        self.assetTypeDcd = try container.decode(AssetTypeDcd.self, forKey: .assetTypeDcd)
        self.assetType = try container.decode(String.self, forKey: .assetType)
        self.nftTypeDcd = try container.decode(NFTType.self, forKey: .nftTypeDcd)
        self.nftMetaUri = try container.decode(String.self, forKey: .nftMetaUri)
        self.nftDirectLink = try container.decodeIfPresent(String.self, forKey: .nftDirectLink)
        self.nftHolderAuthDirectLink = try container.decodeIfPresent(String.self, forKey: .nftHolderAuthDirectLink)
        self.nftAnimationUrl = try container.decodeIfPresent(String.self, forKey: .nftAnimationUrl)
        self.nftMediaUri = try container.decodeIfPresent(String.self, forKey: .nftMediaUri)
        self.nftMetaJson = try container.decodeIfPresent(String.self, forKey: .nftMetaJson)
        self.retryCount = try container.decodeIfPresent(Int.self, forKey: .retryCount)
        
        self.btnNftcancelYn = try container.decode(String.self, forKey: .btnNftcancelYn) == "Y"
        self.btnNftmodifyYn = try container.decode(String.self, forKey: .btnNftmodifyYn) == "Y"
        self.finalizedYn = try container.decodeIfPresent(String.self, forKey: .finalizedYn) == "Y"
        self.binanceSaleYn = try container.decode(String.self, forKey: .binanceSaleYn) == "Y"
        self.btnSendtogameYn = try container.decode(String.self, forKey: .btnSendtogameYn) == "Y"
        self.btnNftsellYn = try container.decode(String.self, forKey: .btnNftsellYn) == "Y"
        self.holderAuthYn = try container.decode(String.self, forKey: .holderAuthYn) == "Y"
    }
}

public struct NFTMetaInfo: Codable {
    struct NFTMetaInfoAttribute: Codable {
        let index: String
        let value: String
    }

    let gameName: String
    let description: String
    let attributes: [NFTMetaInfoAttribute]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gameName = try container.decode(String.self, forKey: .gameName)
        self.description = try container.decode(String.self, forKey: .description)
        self.attributes = try container.decode([NFTMetaInfoAttribute].self, forKey: .attributes)
    }
}
