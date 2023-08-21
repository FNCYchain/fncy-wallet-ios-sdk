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

public struct FncyCurrency: Codable {
    public let assetInfo: FncyAssetInfo
    public let dailyVolumeKrw: Decimal
    public let krwPrice: Decimal
    public let displayBtcPrice: String
    public let displayDailyLowerUsd: String
    public let displayDailyVolumeKrw: String
    public let displayDailyHigherKrw: String
    public let dailyLowerUsd: Decimal
    public let hourChange: Decimal
    public let whitePaperLink: String
    public let displayDailyLowerKrw: String
    public let dailyHigherKrw: Decimal
    public let assetId: Int
    public let displayDailyVolumeUsd: String
    public let displayKrwPrice: String
    public let ethPrice: Decimal
    public let btcPrice: Decimal
    public let dailyHigherUsd: Decimal
    public let usdPrice: Decimal
    public let displayDailyHigherUsd: String
    public let displayEthPrice: String
    public let projectLink: String
    public let dailyLowerKrw: Decimal
    public let displayUsdPrice: String
    public let dailyVolumeUsd: Decimal
    public let symbol: String
    public let dayChange: Decimal
}

extension FncyCurrency : CustomStringConvertible {
    public var description: String {
        return self.prettyJSON()
    }
}
