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

public enum WalletTypeDcd: String, Codable, CustomStringConvertible {
    case HDwallet = "1002001"
    case externalWallet = "1002002"
    public var description: String {
        switch self {
        case .HDwallet: return "HDwallet"
        case .externalWallet: return "externalWallet"
        }
    }
}

public enum AssetTypeDcd: String, Codable, CustomStringConvertible {
    case BSC = "1004001"
    case BEP20 = "1004002"
    case BEP721 = "1004003"
    case ETH = "1004004"
    case ERC20 = "1004005"
    case ERC721 = "1004006"
    
    public var description: String {
        switch self {
        case .BSC: return "bsc"
        case .BEP20: return "bep20"
        case .BEP721: return "bep721"
        case .ETH: return "eth"
        case .ERC20: return "erc20"
        case .ERC721: return "erc721"
        }
    }
}

public enum OwnerOfDcd: String, Codable {
    case inStock = "1005001"
    case forSale = "1005002"
    case soldOut = "1005003"

    var identifier: String {
        switch self {
        case .inStock: return "instock"
        case .forSale: return "forsale"
        case .soldOut: return "soldout"
        }
    }
}

public enum InOutDcd: String, Codable {
    case all = "1006000"
    case deposit = "1006001"
    case withdrawal = "1006002"

    public var id: String? {
        switch self {
        case .all: return nil
        case .deposit: return "deposit"
        case .withdrawal: return "withdrawal"
        }
    }
}

public enum TxStDcd: String, Codable, CustomStringConvertible {
    case pending = "1007001"
    case success = "1007002"
    case failed = "1007003"

    public var description: String {
        switch self {
        case .pending:
            return "Pending"
        case .failed:
            return "Failed"
        case .success:
            return "Success"
        }
    }
}

public enum TransferEvent: String, Codable {
    case transfer = "1008001"
    case gameToWallet = "1008002"
    case walletToGame = "1008003"
    case swap = "1008004"
    case buyMarket = "1008005"
    case forSaleMarket = "1008006"
    case cancelTheSaleMarket = "1008007"
    case soldOutMarket = "1008008"

    public var description: String {
        switch self {
        case .transfer: return "transfer"
        case .gameToWallet: return "game to wallet"
        case .walletToGame: return "wallet to game"
        case .swap: return "swap"
        case .buyMarket: return "buy market"
        case .forSaleMarket: return "for sale market"
        case .cancelTheSaleMarket: return "cancel the sale market"
        case .soldOutMarket: return "sold out market"
        }
    }
}

public enum TicketType: String, Codable {
    case assetTransfer = "1009001"
    case smartContract = "1009002"
    case walletConnect = "1009003"

    var id: String {
        switch self {
        case .assetTransfer:
            return "SIGNATURE_TYPE_FOR_ASSET_TRANSFER"
        case .smartContract:
            return "SIGNATURE_TYPE_FOR_SMARTCONTRACT_EXECUTION"
        case .walletConnect:
            return "SIGNATURE_TYPE_FOR_WALLETCONNECT"
        }
    }
}

public enum NFTType: String, Codable {
    case game = "1015001"
    case basic = "1015002"
    case special = "1015003"

    var id: String {
        switch self {
        case .game:
            return "game"
        case .basic:
            return "basic"
        case .special:
            return "special"
        }
    }
}

public enum WalletSignType: Codable {
    case ethSign
    case ethSignV2
    case ethSignPersonalWithPrefix
    case ethSignWithoutPrefix
    case signEip712StructuredData

    var id: String {
        switch self {
        case .ethSign:
            return "ethSign"
        case .ethSignV2:
            return "ethSignV2"
        case .ethSignPersonalWithPrefix:
            return "ethSignPersonalWithPrefix"
        case .ethSignWithoutPrefix:
            return "ethSignWithoutPrefix"
        case .signEip712StructuredData:
            return "signEip712StructuredData"
        }
    }
}

public enum WalletSecureLevel: Int, Codable {
    case needWalletMigration = 0
    case depositAvailableOnly = 1
    case withrawalAvailable = 2
}
