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

public struct FncyPrice: Codable {
    public let krwPrice: Decimal
    public let usdPrice: Decimal
    public let btcPrice: Decimal
    public let ethPrice: Decimal
    public let displayKrwPrice: String
    public let displayUsdPrice: String
    public let displayBtcPrice: String
    public let displayEthPrice: String
}

extension FncyPrice : CustomStringConvertible {
    public var description: String {
        return self.prettyJSON()
    }
}
