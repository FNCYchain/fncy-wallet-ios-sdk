# Fncy Wallet SDK for iOS

[![Version](https://img.shields.io/cocoapods/v/FncyWallet.svg?style=flat)](https://cocoapods.org/pods/FncyWallet)
[![License](https://img.shields.io/cocoapods/l/FncyWallet.svg?style=flat)](https://cocoapods.org/pods/FncyWallet)
[![Platform](https://img.shields.io/cocoapods/p/FncyWallet.svg?style=flat)](https://cocoapods.org/pods/FncyWallet)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Dependencies

* [Alamofire](https://github.com/Alamofire/Alamofire) >= 5.7
* [SwiftyRSA](https://github.com/TakeScoop/SwiftyRSA) >= 1.7

## Requirements

* Swift 5
* iOS 14

## Installation

**Podfile**
```ruby
pod 'FncyWallet'
```

**Package.swift**
```swift
let package = Package(
  name: "MyPackage",
  dependencies: [
    .package(url: "https://github.com/FNCYchain/fncy-wallet-ios-sdk.git", Version(0,1,0)..<Version(1,0,0))
  ],
  targets: [
    .target(name: "MyTarget", dependencies: ["FncyWallet"])
  ]
)
```

## Documentation



## Example Usage

### Initialization  

```swift
import FncyWallet

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FncyWalletSDK.initSDK(apiKey: "${apikey}",
                              baseURL: "${baseURL}")
        
        return true
    }
```

### Get Wallet

In the imports section:
```swift
import FncyWallet
```
     
```swift
    
    let authToken = "authorizationToken"
    let fncyWallet = FncyWalletCore(authToken: authToken)
    
    guard let walletData = try await fncyWallet.getWallet() else { return }
    
    print(walletData.walletAddress)  
```

### Get GasPrice Info
```swift
    let authToken = "authorizationToken"
    let fncyWallet = FncyWalletCore(authToken: authToken)
    
    guard let gasPriceInfo = try await fncyWallet.getGasPrice(chainId: 3) else { return }
    
    print(gasPriceInfo)
```
 

### Send Fncy 
```swift
    let authToken = "authorizationToken"
    let fncyWallet = FncyWalletCore(authToken: authToken)
    
    guard let walletData = try await fncyWallet.getWallet() else { return }
    
    guard let gasPriceInfo = try await fncyWallet.getGasPrice(chainId: 3) else { return }
    
    guard let ticketInfo = try await fncyWallet.makeTicket(wid: walletData.wid, chainId: 3, signatureType: .assetTransfer, toAddress: "0x1234...", transferVal: "10000000000000000", txGasPrice: gasPriceInfo.middleGasPrice, assetId: 6, txGasLimit: 21000)
    
    guard let sendResult = try await fncyWallet.sendTicket(ticketUuids: ticketInfo.ticketuuid, pinNumber: "000000") 
    
    // Done
```


## Author

Metaverse World, Inc
