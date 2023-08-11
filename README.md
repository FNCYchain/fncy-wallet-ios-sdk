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
FncyWallet is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

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

## Author

Metaverse World, Inc

## License

FncyWallet is available under the Apache License, Version 2.0(the "License"). See the LICENSE file for more info.
