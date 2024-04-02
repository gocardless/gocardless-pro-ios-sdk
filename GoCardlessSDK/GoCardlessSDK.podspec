#
# Be sure to run `pod lib lint GoCardlessSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GoCardlessSDK'
  s.version          = '1.0.0'
  s.summary          = 'GoCardless Pro iOS client library'
  s.description      = <<-DESC
  The GoCardless iOS SDK is a tool that enables developers to integrate GoCardless payments into their iOS applications. To help developers get started, a sample app has been created that demonstrates how to use the SDK. The app provides a clear and practical example of how to implement GoCardless payments within an iOS app.
                       DESC

  s.homepage         = 'https://github.com/gocardless/gocardless-pro-android-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'GoCardless' => 'mobile-sdk@gocardless.com' }
  s.source           = { :git => 'https://github.com/gocardless/gocardless-pro-android-sdk.git', :tag => s.version.to_s }
  s.ios.deployment_target = '16.0'
  s.source_files = 'GoCardlessSDK/Classes/**/*'
  
end
