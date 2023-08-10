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
import Alamofire

public struct APIRequest: CustomStringConvertible {
    let requestUrl: String
    let method: HTTPMethod
    let parameters: [String: Any]?

    public init(requestUrl: String,
                method: HTTPMethod,
                parameters: [String: Any]? = nil) {
        self.requestUrl = requestUrl
        self.method = method
        self.parameters = parameters
    }

    public var description: String {
        let parameters: String = {
            guard let parameters = self.parameters else {
                return "nil"
            }
            return "- parameters : \(String(describing: parameters))"
        }()

        return "- requestUrl : \(self.requestUrl)\r" + "- method : \(self.method)\r" + "- parameters : \(parameters)\r"
    }
}
