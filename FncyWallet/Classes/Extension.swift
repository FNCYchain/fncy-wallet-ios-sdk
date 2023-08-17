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
import CryptoKit
import SwiftyRSA

public extension Data {
    func sha256() -> Data {
        return Data(SHA256.hash(data: self))
    }

    func toHexString() -> String {
        return self.compactMap { String(format: "%02x", $0) }.joined()
    }
}

public extension String {
    func addHexPrefix() -> String {
        if !self.hasPrefix("0x") {
            return "0x" + self
        }
        return self
    }

    func stripHexPrefix() -> String {
        if self.hasPrefix("0x") {
            let indexStart = self.index(self.startIndex, offsetBy: 2)
            return String(self[indexStart...])
        }
        return self
    }

    var data: Data {
        return Data(self.utf8)
    }

    func encryptRSA(_ pubKey: String) throws -> String {
        do {
            let publicKey = try PublicKey(base64Encoded: pubKey)
            let clearMessage = try ClearMessage(string: self, using: .utf8)
            let encrypted = try clearMessage.encrypted(with: publicKey,
                                                padding: .PKCS1)
            let base64String = encrypted.base64String
            return base64String

        } catch let error {
            throw error
        }
    }
}

extension Encodable {
    func prettyJSON() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self),
            let output = String(data: data, encoding: .utf8)
            else { return "Error converting \(self) to JSON string" }
        return output
    }
}
