Pod::Spec.new do |spec|
  spec.name             = "SwiftComponentKitNetwork"
  spec.version          = "1.0.0"
  spec.summary          = "Swift网络请求库"
  spec.description      = <<-DESC
    基于Alamofire和Combine的网络请求封装
  DESC
  
  spec.homepage         = "https://github.com/mokong/SwiftComponentKit"
  spec.license          = { :type => "MIT", :file => "LICENSE" }
  spec.author           = { "mokong" => "" }
  spec.source           = { :git => "https://github.com/mokong/SwiftComponentKit.git", :tag => "#{spec.version}" }
  
  spec.ios.deployment_target = "13.0"
  spec.swift_version = "5.0"
  
  spec.source_files = "Sources/**/*.swift"
  spec.frameworks = "Foundation", "Combine"
  
  spec.dependency "Alamofire", "~> 5.0"
end

