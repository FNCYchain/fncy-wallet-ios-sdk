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

public struct FncyTransaction: Codable {
    public let assetInfo: FncyAssetInfo //
    public let blockNumber: Decimal?
    public let txFee: Decimal?
    public let transferEventDcd: TransferEvent
    public let transferSeq: Int
    public let transferVal: Decimal // 
    public let blockTimestamp: TimeInterval
    public let inOutDcd: InOutDcd
    public let inOut: String
    public let transferEventIndex: Int?
    public let transferMethod: String //  : 일반적인 자산 전송의 경우 transfer, 그 외의 경우 contract의
    public let historyUts: TimeInterval
    public let historySeq: Int
    public let transferEvent: String
    public let txIndex: Int?
    public let txVal: Decimal?
    public let txAnnotation: String
    public let transferTo: String
    public let wid: Int //
    public let displayTxFee: String?
    public let chainId: Int? //
    public let walletAddress: String
    public let displayTransferVal: String
    public let txNonce: Int?
    public let transferFrom: String
    public let txSt: String?
    public let blockHash: String?
    public let historyKst: TimeInterval? // TranferMethod  이력 변경이 발생한 타임스탬프
    public let txStDcd: TxStDcd?
    public let txId: String? //
    //트랜잭션 전송에 사용한 가스비
    
    
}

extension FncyTransaction : CustomStringConvertible {
    public var description: String {
        return self.prettyJSON()
    }
}
