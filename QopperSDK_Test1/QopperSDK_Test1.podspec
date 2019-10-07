#
#  Be sure to run `pod spec lint QopperSDK_Test1.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

spec.name         = "QopperSDK_Test1"
spec.version      = "1.0.0"
spec.summary      = "This is for test how to create cocoapod."
spec.description  = "test test test test tes test tes test test test tset estst sett sett set tes test test "
spec.homepage     = "https://github.com/deeprajjadhav/QopperSDK_Test1"
spec.license      = "MIT"
spec.author             = { "name" => "email" }
spec.platform     = :ios, "11.0"
spec.source       = { :git => "https://github.com/deeprajjadhav/QopperSDK_Test1.git", :tag => "1.0.0" }
spec.source_files  = "QopperSDK_Test1/**/*"
spec.exclude_files = "QopperSDK_Test1/QopperSDK_Test1/*.plist"
spec.swift_versions = "4.0"
spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end
