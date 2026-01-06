Pod::Spec.new do |spec|
  spec.name             = "SwiftComponentKitImage"
  spec.version          = "1.0.0"
  spec.summary          = "Swift图片处理库"
  spec.description      = <<-DESC
    提供图片处理、加载和缓存功能
  DESC
  
  spec.homepage         = "https://github.com/mokong/SwiftComponentKit"
  spec.license          = { :type => "MIT", :file => "LICENSE" }
  spec.author           = { "mokong" => "" }
  spec.source           = { :git => "https://github.com/mokong/SwiftComponentKit.git", :tag => "#{spec.version}" }
  
  spec.ios.deployment_target = "11.0"
  spec.swift_version = "5.0"
  
  spec.source_files = "Sources/**/*.swift"
  spec.frameworks = "UIKit", "Foundation"
end

