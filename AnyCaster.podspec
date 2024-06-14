#
#  Be sure to run `pod spec lint AnyCaster.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name = "AnyCaster"
  spec.version = "0.1.1"
  spec.summary = "A Swift library for robust type casting and value mapping."

  spec.description = <<-DESC
AnyCaster is a versatile Swift library that simplifies type casting of Any values. 
It provides a suite of tools to safely cast values to desired types, with additional 
capabilities for handling dictionaries and arrays. The library ensures type safety 
by throwing appropriate errors when casts fail, making it a reliable choice for 
dynamic type handling in Swift projects.
DESC

  spec.homepage = "https://github.com/roman-okdi/AnyCaster"

  spec.license  = { :type => "MIT", :file => "LICENSE" }

  spec.authors = { "okdi" => "newmailri@gmail.com" }
  
  spec.swift_version = '5.0'
  
  spec.ios.deployment_target = "13.0"
  spec.osx.deployment_target = "10.15"
  spec.watchos.deployment_target = "6.0"
  spec.tvos.deployment_target = "13.0"

  spec.source = { :git => "https://github.com/roman-okdi/AnyCaster.git", :tag => "#{spec.version}" }

  spec.source_files = "Sources/AnyCaster/**/*.swift"

  spec.test_spec 'UnitTests' do |tests|
    tests.source_files = 'Tests/AnyCasterTests/**/*.swift'
    tests.test_type = :unit
    tests.frameworks = ['XCTest']
    tests.dependency 'Nimble', '~> 13.0.0'
  end

end
