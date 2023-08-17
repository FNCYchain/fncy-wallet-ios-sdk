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
    public let ownerOfDcd: OwnerOfDcd
    public let ownerOf: String
    public let nftInfo: NFTInfo
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nftInfo = try container.decode(NFTInfo.self, forKey: .nftInfo)
        self.ownerOf = try container.decode(String.self, forKey: .ownerOf)
        self.nftId = try container.decode(Int.self, forKey: .nftId)
        self.ownerOfDcd = try container.decode(OwnerOfDcd.self, forKey: .ownerOfDcd)
        self.wid = try container.decodeIfPresent(Int.self, forKey: .wid)
    }
}

extension FncyNFT : CustomStringConvertible {
    public var description: String {
        return self.prettyJSON()
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
    public let nftSymbol: String
    public let nftSymbolImg: String
    public let assetTypeDcd: AssetTypeDcd
    public let assetType: String
    public let nftMetaUri: String
    public let nftDirectLink: String?
    public let nftHolderAuthDirectLink: String?
    public let nftAnimationUrl: String?
    public let nftMediaUri: String?
    public let nftMetaJson: String?
    
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
        self.nftSymbol = try container.decode(String.self, forKey: .nftSymbol)
        self.nftSymbolImg = try container.decode(String.self, forKey: .nftSymbolImg)
        self.assetTypeDcd = try container.decode(AssetTypeDcd.self, forKey: .assetTypeDcd)
        self.assetType = try container.decode(String.self, forKey: .assetType)
        self.nftMetaUri = try container.decode(String.self, forKey: .nftMetaUri)
        self.nftDirectLink = try container.decodeIfPresent(String.self, forKey: .nftDirectLink)
        self.nftHolderAuthDirectLink = try container.decodeIfPresent(String.self, forKey: .nftHolderAuthDirectLink)
        self.nftAnimationUrl = try container.decodeIfPresent(String.self, forKey: .nftAnimationUrl)
        self.nftMediaUri = try container.decodeIfPresent(String.self, forKey: .nftMediaUri)
        self.nftMetaJson = try container.decodeIfPresent(String.self, forKey: .nftMetaJson)
    }
}

extension NFTInfo : CustomStringConvertible {
    public var description: String {
        return self.prettyJSON()
    }
}
