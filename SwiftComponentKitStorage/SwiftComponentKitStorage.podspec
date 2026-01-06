Pod::Spec.new do |spec|
  spec.name             = "SwiftComponentKitStorage"
  spec.version          = "1.0.0"
  spec.summary          = "Swift数据存储库"
  spec.description      = <<-DESC
    提供数据存储功能，包括UserDefaults、Keychain、缓存等
  DESC
  
  spec.homepage         = "https://github.com/mokong/SwiftComponentKit"
  spec.license          = { :type => "MIT", :file => "LICENSE" }
  spec.author           = { "mokong" => "" }
  spec.source           = { :git => "https://github.com/mokong/SwiftComponentKit.git", :tag => "#{spec.version}" }
  
  spec.ios.deployment_target = "11.0"
  spec.swift_version = "5.0"
  
  spec.source_files = "Sources/**/*.swift"
  spec.frameworks = "Foundation", "Security"
  
  spec.dependency "SwiftComponentKitUtils", :path => "../SwiftComponentKitUtils"
end

