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

public struct ResultInfo: Codable {
    public let message: String
    public let code: String
    public let isSuccess: Bool
    public let number: Int
}

extension ResultInfo : CustomStringConvertible  {
    public var description: String {
        return self.prettyJSON()
    }
}

internal struct ResultData: ResultPresentable {
    public let resultType: String?
    public let result: ResultInfo?
}

extension ResultData : CustomStringConvertible  {
    public var description: String {
        return self.prettyJSON()
    }
}

internal struct WalletMakeResultData: ResultPresentable {
    public var resultType: String?
    public var result: ResultInfo?
    public let wid: Int
}

extension WalletMakeResultData : CustomStringConvertible  {
    public var description: String {
        return self.prettyJSON()
    }
}
