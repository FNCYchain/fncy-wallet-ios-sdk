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
    public let balancePlainString : String? // ??
    public let displayBalance: String?
    public let assetInfo: FncyAssetInfo
    public let prices: FncyPrice
    
    
    
    
    
    

    
//    public let displayYn: String?
//
//    public let assetOrd: Int
//    public let gameNm: String?
//    public let gameCode: String?
}


extension FncyAsset : CustomStringConvertible {
    public var description: String {
        return self.prettyJSON()
    }
}
