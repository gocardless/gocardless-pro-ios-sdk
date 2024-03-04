#
# Be sure to run `pod lib lint GoCardlessSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GoCardlessSDK'
  s.version          = '0.1.0'
  s.summary          = 'A short description of GoCardlessSDK.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Gunhan Sancar/GoCardlessSDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Gunhan Sancar' => 'cgnhnc@gmail.com' }
  s.source           = { :git => 'https://github.com/GunhanSancar/GoCardlessSDK.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.source_files = 'GoCardlessSDK/Classes/**/*'
  
end
