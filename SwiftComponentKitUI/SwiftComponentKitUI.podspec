Pod::Spec.new do |spec|
  spec.name             = "SwiftComponentKitUI"
  spec.version          = "1.0.0"
  spec.summary          = "Swift通用UI组件库"
  spec.description      = <<-DESC
    提供常用的UI组件和扩展，包括UIColor、UIView、UIButton、Alert、Toast等
  DESC
  
  spec.homepage         = "https://github.com/mokong/SwiftComponentKit"
  spec.license          = { :type => "MIT", :file => "LICENSE" }
  spec.author           = { "mokong" => "" }
  spec.source           = { :git => "https://github.com/mokong/SwiftComponentKit.git", :tag => "#{spec.version}" }
  
  spec.ios.deployment_target = "11.0"
  spec.swift_version = "5.0"
  
  spec.source_files = "Sources/**/*.swift"
  spec.frameworks = "UIKit", "Foundation"
  
  spec.dependency "SnapKit", "~> 5.0"
end

