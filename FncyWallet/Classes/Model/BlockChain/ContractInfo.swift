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

public struct ContractInfo: Codable {
    public let assetSymbolImg: String
    public let assetId: Int
    public let assetSymbol: String
    public let assetDecimal: Int
    public let contractAddress: String
    public let assetNm: String
    public let assetDesc: String?
    let gcoinYn: Bool
    let cubeYn: Bool
    let fncyYn: Bool?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.assetSymbolImg = try container.decode(String.self, forKey: .assetSymbolImg)
        self.assetId = try container.decode(Int.self, forKey: .assetId)
        self.gcoinYn = try container.decode(String.self, forKey: .gcoinYn) == "Y"
        self.fncyYn = try container.decodeIfPresent(String.self, forKey: .fncyYn) == "Y"
        self.assetSymbol = try container.decode(String.self, forKey: .assetSymbol)
        self.assetDecimal = try container.decode(Int.self, forKey: .assetDecimal)
        self.cubeYn = try container.decode(String.self, forKey: .cubeYn) == "Y"
        self.contractAddress = try container.decode(String.self, forKey: .contractAddress)
        self.assetNm = try container.decode(String.self, forKey: .assetNm)
        self.assetDesc = try container.decodeIfPresent(String.self, forKey: .assetDesc)
    }
}

extension ContractInfo : CustomStringConvertible {
    public var description: String {
        return self.prettyJSON()
    }
}
