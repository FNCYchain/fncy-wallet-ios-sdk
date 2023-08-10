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
    public let useGame: Bool
    public let wid: Int
    public let displayOrd: Int
    public let walletTypeDcd: WalletTypeDcd
    public let bookmarkYn: Bool
    public let walletIndex: Int
    public let secureLevel: WalletSecureLevel
    public let chainId: Int
    public let walletAddress: String
    public let walletType: String
    public let totalCubeBalance: Decimal // caution

    public let displayYn: Bool
    public let updateKst: TimeInterval
    public let nftCount: Int
    public let createKst: TimeInterval
    public let walletNm: String
    public let fid: Int
    public let displayTotalCubeBalance: Decimal // caution

    public let externalServiceProvider: String?
    public let externalServiceProviderDcd: String?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.useGame = try container.decode(Bool.self, forKey: .useGame)
        self.wid = try container.decode(Int.self, forKey: .wid)
        self.displayOrd = try container.decode(Int.self, forKey: .displayOrd)
        self.walletTypeDcd = try container.decode(WalletTypeDcd.self, forKey: .walletTypeDcd)
        self.bookmarkYn = try container.decode(String.self, forKey: .bookmarkYn) == "Y"
        self.walletIndex = try container.decode(Int.self, forKey: .walletIndex)
        self.secureLevel = try container.decode(WalletSecureLevel.self, forKey: .secureLevel)
        self.chainId = try container.decode(Int.self, forKey: .chainId)
        self.walletAddress = try container.decode(String.self, forKey: .walletAddress)
        self.walletType = try container.decode(String.self, forKey: .walletType)

        if let value = try? container.decode(String.self, forKey: .totalCubeBalance) {
            self.totalCubeBalance = Decimal(string: value) ?? Decimal(0)
        } else {
            self.totalCubeBalance = try container.decode(Decimal.self, forKey: .totalCubeBalance)
        }

        self.displayYn = try container.decode(String.self, forKey: .displayYn) == "Y"
        self.updateKst = try container.decode(TimeInterval.self, forKey: .updateKst)
        self.nftCount = try container.decode(Int.self, forKey: .nftCount)
        self.createKst = try container.decode(TimeInterval.self, forKey: .createKst)
        self.walletNm = try container.decode(String.self, forKey: .walletNm)
        self.fid = try container.decode(Int.self, forKey: .fid)

        if let value = try? container.decode(String.self, forKey: .displayTotalCubeBalance) {
            self.displayTotalCubeBalance = Decimal(string: value) ?? Decimal(0)
        } else {
            self.displayTotalCubeBalance = try container.decode(Decimal.self, forKey: .displayTotalCubeBalance)
        }

        self.externalServiceProvider = try container.decodeIfPresent(String.self, forKey: .externalServiceProvider)
        self.externalServiceProviderDcd = try container.decodeIfPresent(String.self, forKey: .externalServiceProviderDcd)
    }
}
