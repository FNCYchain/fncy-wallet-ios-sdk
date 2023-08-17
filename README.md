# Fncy Wallet SDK for iOS

[![Version](https://img.shields.io/cocoapods/v/FncyWallet.svg?style=flat)](https://cocoapods.org/pods/FncyWallet)
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

### **Podfile**
```ruby
#Podfile 
use_frameworks!

platform :ios, '14.0'

target 'YOUR_TARGET_NAME' do
    pod 'FncyWallet'
end
```
Replace `YOUR_TARGET_NAME` and then, in the `Podfile` directory, type:

```bash
$ pod install
```

### **Package.swift**
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

## Getting Started

### initialize Fncy Wallet SDK  

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

### Get Wallet Address

In the imports section:
```swift
import FncyWallet
```
     
```swift
    let authToken = "authorizationToken"
    let fncyWallet = FncyWalletCore(authToken: authToken)
    
    let walletData = try await fncyWallet.getWallet()
    
    print(walletData.walletAddress)  
```

## Documentation 

* [GitBook : Fncy Wallet SDK for iOS](https://app.gitbook.com/o/sxbvsaQu6S0zvfR1DBLL/s/rtEQIDnbkvSB2krcokD0/for-developers/fncy-mobile-app/fncy-wallet-sdk/ios)
 
## Author

Metaverse World, Inc
