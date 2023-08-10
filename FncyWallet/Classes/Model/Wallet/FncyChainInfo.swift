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

public struct FncyChainInfo: Codable {
    public let majorAssetInfo: MajorAssetInfo
    public let nativeCoinInfo: NativeCoinInfo
    public let evmChainId: Double
    public let chainDesc: String
    public let chainType: String
    public let chainNm: String
    public let chainId: Int
    public let chainTypeDcd: String
    public let updateKst: Double
    public let createKst: Double
    public let chainActiveYn: Bool
    public let testnetYn: Bool
    public let bridgeAvailableAssets: Data?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.majorAssetInfo = try container.decode(MajorAssetInfo.self, forKey: .majorAssetInfo)
        self.nativeCoinInfo = try container.decode(NativeCoinInfo.self, forKey: .nativeCoinInfo)
        self.evmChainId = try container.decode(Double.self, forKey: .evmChainId)
        self.chainDesc = try container.decode(String.self, forKey: .chainDesc)
        self.chainType = try container.decode(String.self, forKey: .chainType)
        self.chainNm = try container.decode(String.self, forKey: .chainNm)
        self.chainId = try container.decode(Int.self, forKey: .chainId)
        self.chainTypeDcd = try container.decode(String.self, forKey: .chainTypeDcd)
        self.updateKst = try container.decode(Double.self, forKey: .updateKst)
        self.createKst = try container.decode(Double.self, forKey: .createKst)
        self.chainActiveYn = try container.decode(String.self, forKey: .chainActiveYn) == "Y"
        self.testnetYn = try container.decode(String.self, forKey: .testnetYn) == "Y"
        self.bridgeAvailableAssets = try container.decodeIfPresent(Data.self, forKey: .bridgeAvailableAssets)
    }
}

public struct MajorAssetInfo: Codable {
    public let majorAssetId: Int
    public let majorAssetSymbol: String
    public let contractAddress: String
    public let majorAssetDecimal: Int
    public let majorAssetSymbolImg: String
}

public struct NativeCoinInfo: Codable {
    public let nativeCoinDecimal: Double
    public let nativeCoinId: Double
    public let nativeCoinSymbolImg: String
    public let nativeCoinSymbol: String
}
