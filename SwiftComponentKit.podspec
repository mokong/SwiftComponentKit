Pod::Spec.new do |spec|
  spec.name             = "SwiftComponentKit"
  spec.version          = "1.0.0"
  spec.summary          = "Swift通用组件库集合"
  spec.description      = <<-DESC
    SwiftComponentKit是一个通用的Swift组件库集合，包含UI组件、Foundation扩展、网络请求、数据存储、工具和多语言等功能。
    
    模块包括：
    - SwiftComponentKitUI: UI组件和扩展
    - SwiftComponentKitFoundation: Foundation扩展
    - SwiftComponentKitImage: 图片处理
    - SwiftComponentKitNetwork: 网络请求
    - SwiftComponentKitStorage: 数据存储
    - SwiftComponentKitUtils: 工具库
    - SwiftComponentKitLocalization: 多语言
  DESC
  
  spec.homepage         = "https://github.com/mokong/SwiftComponentKit"
  spec.license          = { :type => "MIT", :file => "LICENSE" }
  spec.author           = { "mokong" => "" }
  spec.source           = { :git => "https://github.com/mokong/SwiftComponentKit.git", :tag => "#{spec.version}" }
  
  spec.ios.deployment_target = "13.0"
  spec.swift_version = "5.0"
  
  # UI组件库
  spec.subspec "UI" do |ui|
    ui.source_files = "SwiftComponentKitUI/Sources/**/*.swift"
    ui.dependency "SnapKit", "~> 5.0"
    ui.frameworks = "UIKit", "Foundation"
  end
  
  # Foundation扩展库
  spec.subspec "Foundation" do |foundation|
    foundation.source_files = "SwiftComponentKitFoundation/Sources/**/*.swift"
    foundation.frameworks = "Foundation", "UIKit"
  end
  
  # 图片处理库
  spec.subspec "Image" do |image|
    image.source_files = "SwiftComponentKitImage/Sources/**/*.swift"
    image.frameworks = "UIKit", "Foundation"
  end
  
  # 网络请求库
  spec.subspec "Network" do |network|
    network.source_files = "SwiftComponentKitNetwork/Sources/**/*.swift"
    network.dependency "Alamofire", "~> 5.4"
    network.frameworks = "Foundation", "Combine"
  end
  
  # 工具库
  spec.subspec "Utils" do |utils|
    utils.source_files = "SwiftComponentKitUtils/Sources/**/*.swift"
    utils.frameworks = "Foundation", "UIKit", "SystemConfiguration"
  end
  
  # 数据存储库
  spec.subspec "Storage" do |storage|
    storage.source_files = "SwiftComponentKitStorage/Sources/**/*.swift"
    storage.dependency "SwiftComponentKit/Utils"
    storage.frameworks = "Foundation", "Security"
  end
  
  # 多语言库
  spec.subspec "Localization" do |localization|
    localization.source_files = "SwiftComponentKitLocalization/Sources/**/*.swift"
    localization.frameworks = "Foundation"
  end
  
  # 默认包含所有子模块
  spec.default_subspecs = "UI", "Foundation", "Image", "Network", "Utils", "Storage", "Localization"
end

