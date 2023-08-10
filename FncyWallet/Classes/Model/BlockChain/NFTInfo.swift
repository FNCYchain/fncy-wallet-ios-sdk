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

public struct NFTItemInfo: Codable {
    let chainNm: String
    let nftSymbol: String
    let tokenId: String
    let assetType: String
    let assetTypeDcd: AssetTypeDcd
    let contractAddress: String
    let chainId: Int
    let marketId: String?
    let retryCount: Int
    let nftSymbolImg: String
    let nftNm: String
    let nftId: Int
    let useYn: Bool

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.chainNm = try container.decode(String.self, forKey: .chainNm)
        self.nftSymbol = try container.decode(String.self, forKey: .nftSymbol)
        self.tokenId = try container.decode(String.self, forKey: .tokenId)
        self.assetType = try container.decode(String.self, forKey: .assetType)
        self.assetTypeDcd = try container.decode(AssetTypeDcd.self, forKey: .assetTypeDcd)
        self.contractAddress = try container.decode(String.self, forKey: .contractAddress)
        self.chainId = try container.decode(Int.self, forKey: .chainId)
        self.marketId = try container.decodeIfPresent(String.self, forKey: .marketId)
        self.retryCount = try container.decode(Int.self, forKey: .retryCount)
        self.nftSymbolImg = try container.decode(String.self, forKey: .nftSymbolImg)
        self.nftNm = try container.decode(String.self, forKey: .nftNm)
        self.nftId = try container.decode(Int.self, forKey: .nftId)
        self.useYn = try container.decode(String.self, forKey: .useYn) == "Y"
    }
}
