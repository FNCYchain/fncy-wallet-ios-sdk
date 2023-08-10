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

public struct Status: Codable {
    let code: Int
    let message: String
}

// ListData<C>
public struct ListData<C: Codable>: Codable {
    public let items: C?
    public let resultType: String?
    public let result: ResultInfo?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ListData<C>.CodingKeys.self)
        self.resultType = try container.decodeIfPresent(String.self, forKey: ListData<C>.CodingKeys.resultType)
        self.result = try container.decodeIfPresent(ResultInfo.self, forKey: ListData<C>.CodingKeys.result)
        self.items = try container.decodeIfPresent(C.self, forKey: ListData<C>.CodingKeys.items)
    }
}

// PagingListData<C>
public struct PagingListData<C: Codable>: Codable {
    public let items: C?
    public let paging: Paging?
    public let resultType: String?
    public let result: ResultInfo?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PagingListData<C>.CodingKeys.self)
        self.paging = try container.decodeIfPresent(Paging.self, forKey: PagingListData<C>.CodingKeys.paging)
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

// enum ResultType : String, Codable {
//    case UserInsertResultCode = "UserInsertResultCodes"
// }

// 성공
//          "resultType": "UserInsertResultCodes",
//          "result": {
//            "isSuccess": true,
//            "code": "SUCCESS",
//            "number": 200,
//            "message": "SUCCESS"
//          }

//  실패
//        {
//          "result" : {
//            "code" : "ACCEPTED",
//            "number" : 202,
//            "message" : "ACCEPTED: 이미 동기화 되어있는 FID",
//            "isSuccess" : false
//          },
//          "resultType" : "UserInsertResultCodes"
//        }
