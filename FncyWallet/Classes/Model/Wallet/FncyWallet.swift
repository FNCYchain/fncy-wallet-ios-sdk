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

public struct FncyWallet: Codable {
    public let wid: Int
    public let walletAddress: String
    public let walletNm: String
    public let secureLevel: WalletSecureLevel
    public let nftCount: Int
    public let createKst: TimeInterval
    public let updateKst: TimeInterval

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.wid = try container.decode(Int.self, forKey: .wid)
        self.secureLevel = try container.decode(WalletSecureLevel.self, forKey: .secureLevel)
        self.walletAddress = try container.decode(String.self, forKey: .walletAddress)
        self.updateKst = try container.decode(TimeInterval.self, forKey: .updateKst)
        self.nftCount = try container.decode(Int.self, forKey: .nftCount)
        self.createKst = try container.decode(TimeInterval.self, forKey: .createKst)
        self.walletNm = try container.decode(String.self, forKey: .walletNm)
    }
}

extension FncyWallet : CustomStringConvertible {
    public var description: String {
        return self.prettyJSON()
    }
}
