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

public protocol ResultPresentable : Codable {
    var resultType: String? { get }
    var result: ResultInfo? { get }
}

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

internal struct PublicKeyData: ResultPresentable {
    public var resultType: String?
    public var result: ResultInfo?
    public let userRsaPubKey: String?
}

internal struct WalletSignResult: ResultPresentable {
    public var resultType: String?
    public var result: ResultInfo?
    public let signature: String?
}

internal struct AddressValidationResult: ResultPresentable {
    public var resultType: String?
    public var result: ResultInfo?
    public let isValid: Bool
}

extension AddressValidationResult : CustomStringConvertible {
    public var description: String {
        return self.prettyJSON()
    }
}

internal struct ListData<C: Codable>: ResultPresentable {
    let items: C?
    let resultType: String?
    let result: ResultInfo?
    let wid : Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ListData<C>.CodingKeys.self)
        self.resultType = try container.decodeIfPresent(String.self, forKey: .resultType)
        self.result = try container.decodeIfPresent(ResultInfo.self, forKey: .result)
        self.items = try container.decodeIfPresent(C.self, forKey: .items)
        
        self.wid = try container.decodeIfPresent(Int.self, forKey: .wid)
    }
}

// PagingListData<C>
internal struct PagingListData<C: Codable>: ResultPresentable {
    let items: C?
    let paging: Paging?
    let resultType: String?
    let result: ResultInfo?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PagingListData<C>.CodingKeys.self)
        self.paging = try container.decodeIfPresent(Paging.self, forKey: .paging)
        self.resultType = try container.decodeIfPresent(String.self, forKey: PagingListData<C>.CodingKeys.resultType)
        self.result = try container.decodeIfPresent(ResultInfo.self, forKey: PagingListData<C>.CodingKeys.result)
        self.items = try container.decodeIfPresent(C.self, forKey: PagingListData<C>.CodingKeys.items)
    }
}

internal struct Paging: Codable {
    public let pageNo: Int
    public let pageSize: Int
    public let totalCount: Int
    public let hasMore: Bool
}
