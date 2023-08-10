#
# Be sure to run `pod lib lint FncyWallet.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FncyWallet'
  s.version          = '0.1.0'
  s.summary          = 'FNCY Wallet for iOS'
  s.homepage         = 'https://github.com/FNCYchain/fncy_wallet_ios'
  s.license          = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.author           = { 'MetaverseWorld, Inc.' }
  s.source           = { :git => 'https://github.com/FNCYchain/fncy_wallet_ios', :tag => s.version.to_s }
  s.swift_version = '5.0'
  s.ios.deployment_target = '14.0'
  
  s.source_files = 'FncyWallet/Classes/**/*'
  s.frameworks = 'CryptoKit'
  s.dependency 'Alamofire', '~> 5.7'
               'SwiftyRSA', '~> 1.8'
end
