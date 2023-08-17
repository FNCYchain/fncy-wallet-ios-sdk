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

public struct FncyWalletResponse<C: Codable>: Codable {
    let apiVersion: String?
    let status: Status
    let data: C
}

extension FncyWalletResponse : CustomStringConvertible  {
    public var description: String {
        return self.prettyJSON()
    }
}



public struct Status: Codable {
    let code: Int
    let message: String
}

extension Status : CustomStringConvertible  {
    public var description: String {
        return self.prettyJSON()
    }
}


public protocol ResultPresentable : Codable {
    var resultType: String? { get }
    var result: ResultInfo? { get }
}

// ListData<C>
public struct ListData<C: Codable>: ResultPresentable {
    public let items: C?
    public let resultType: String?
    public let result: ResultInfo?
    
    public let wid : Int?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ListData<C>.CodingKeys.self)
        self.resultType = try container.decodeIfPresent(String.self, forKey: .resultType)
        self.result = try container.decodeIfPresent(ResultInfo.self, forKey: .result)
        self.items = try container.decodeIfPresent(C.self, forKey: .items)
        
        self.wid = try container.decodeIfPresent(Int.self, forKey: .wid)
    }
}

// PagingListData<C>
public struct PagingListData<C: Codable>: ResultPresentable {
    public let items: C?
    public let paging: Paging?
    public let resultType: String?
    public let result: ResultInfo?
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PagingListData<C>.CodingKeys.self)
        self.paging = try container.decodeIfPresent(Paging.self, forKey: .paging)
        self.resultType = try container.decodeIfPresent(String.self, forKey: PagingListData<C>.CodingKeys.resultType)
        self.result = try container.decodeIfPresent(ResultInfo.self, forKey: PagingListData<C>.CodingKeys.result)
        self.items = try container.decodeIfPresent(C.self, forKey: PagingListData<C>.CodingKeys.items)
    }
}

public struct Paging: Codable {
    public let pageNo: Int
    public let pageSize: Int
    public let totalCount: Int
    public let hasMore: Bool
}

public typealias EmptyType = FncyEmptyType

public struct FncyEmptyType : Codable {}


