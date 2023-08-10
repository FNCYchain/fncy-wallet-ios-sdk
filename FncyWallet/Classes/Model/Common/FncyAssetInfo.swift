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

public struct FncyAssetInfo: Codable {
    public let assetTypeDcd: AssetTypeDcd?
    public let assetSymbol: String?
    public let assetDecimal: Int
    public let contractAddress: String?
    public let chainNm: String?
    public let chainId: Int?
    public let assetNm: String?
    public let assetSymbolImg: String?
    public let assetId: Int
    public let assetType: String?
    public let defaultAssetYn: Bool
    public let cubeYn: Bool
    public let assetButtonType: String?
    public let assetButtonTypeDcd: String?
    public let gcoinYn: Bool?
    public let gameCode: String?
    public let assetOrder: Int?
    public let assetDesc: String?
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.assetType = try container.decodeIfPresent(String.self, forKey: .assetType)
        self.assetTypeDcd = try container.decodeIfPresent(AssetTypeDcd.self, forKey: .assetTypeDcd)
        self.assetSymbol = try container.decodeIfPresent(String.self, forKey: .assetSymbol)
        self.assetDecimal = try container.decode(Int.self, forKey: .assetDecimal)
        self.contractAddress = try container.decodeIfPresent(String.self, forKey: .contractAddress)
        self.chainNm = try container.decodeIfPresent(String.self, forKey: .chainNm)
        self.defaultAssetYn = try container.decodeIfPresent(String.self, forKey: .defaultAssetYn) == "Y"
        self.chainId = try container.decodeIfPresent(Int.self, forKey: .chainId)
        self.assetNm = try container.decodeIfPresent(String.self, forKey: .assetNm)
        self.assetSymbolImg = try container.decodeIfPresent(String.self, forKey: .assetSymbolImg)
        self.cubeYn = try container.decodeIfPresent(String.self, forKey: .cubeYn) == "Y"
        self.assetId = try container.decode(Int.self, forKey: .assetId)
        self.assetButtonType = try container.decodeIfPresent(String.self, forKey: .assetButtonType)
        self.assetButtonTypeDcd = try container.decodeIfPresent(String.self, forKey: .assetButtonTypeDcd)
        self.gcoinYn = try container.decodeIfPresent(String.self, forKey: .gcoinYn) == "Y"
        self.gameCode = try container.decodeIfPresent(String.self, forKey: .gameCode)
        self.assetOrder = try container.decodeIfPresent(Int.self, forKey: .assetOrder)
        self.assetDesc = try container.decodeIfPresent(String.self, forKey: .assetDesc)
    }
}
