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

class FncyUtil {
    static func pinStringValidationCheck(_ string: String) throws {
        guard string.count == 6 else {
            throw FncyWalletError.clientFailed(reason: .pinStringIsTooLong, errorMessage: nil)
        }
        let regex = try NSRegularExpression(pattern: "[0-9]{6}", options: .init(rawValue: 0))
        let matchResult = regex.matches(in: string,
                                        options: .init(rawValue: 0),
                                        range: NSRange(location: 0, length: string.count))
        guard !matchResult.isEmpty else {
            throw FncyWalletError.clientFailed(reason: .invalidCharactersAreIncluded, errorMessage: nil)
        }
    }
}
