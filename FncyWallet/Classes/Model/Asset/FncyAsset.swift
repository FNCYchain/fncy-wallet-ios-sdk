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

public struct FncyAsset: Codable {
    public let wid: Int
    public let chainId: Int
    public let assetSeq: Int
    public let balance: Decimal?
    public let balancePlainString : String?
    public let displayBalance: String?
    public let assetInfo: FncyAssetInfo
    public let prices: FncyPrice
}

extension FncyAsset : CustomStringConvertible {
    public var description: String {
        return self.prettyJSON()
    }
}

public struct FncyAssetInfo: Codable {
    public let chainId: Int?
    public let chainNm: String?
    public let assetId: Int
    public let assetNm: String?
    public let assetSymbol: String?
    public let assetSymbolImg: String?
    public let assetType: String?
    public let assetTypeDcd: AssetTypeDcd?
    public let contractAddress: String?
    public let assetDecimal: Int
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.assetType = try container.decodeIfPresent(String.self, forKey: .assetType)
        self.assetTypeDcd = try container.decodeIfPresent(AssetTypeDcd.self, forKey: .assetTypeDcd)
        self.assetSymbol = try container.decodeIfPresent(String.self, forKey: .assetSymbol)
        self.assetDecimal = try container.decode(Int.self, forKey: .assetDecimal)
        self.contractAddress = try container.decodeIfPresent(String.self, forKey: .contractAddress)
        self.chainNm = try container.decodeIfPresent(String.self, forKey: .chainNm)
        self.chainId = try container.decodeIfPresent(Int.self, forKey: .chainId)
        self.assetNm = try container.decodeIfPresent(String.self, forKey: .assetNm)
        self.assetSymbolImg = try container.decodeIfPresent(String.self, forKey: .assetSymbolImg)
        self.assetId = try container.decode(Int.self, forKey: .assetId)
    }
}

extension FncyAssetInfo : CustomStringConvertible  {
    public var description: String {
        return self.prettyJSON()
    }
}
