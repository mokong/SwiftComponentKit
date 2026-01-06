# SwiftComponentKit

[English](README.md) | **中文**

[![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-11.0+-blue.svg)](https://www.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Swift通用组件库集合，提供常用的UI组件、Foundation扩展、网络请求、数据存储等功能。采用模块化设计，可按需引入，减少包体积。

## ✨ 特性

- 🎨 **UI组件**：Alert、Toast、Loading、EmptyState、Refresh等常用组件
- 🔧 **Foundation扩展**：String、Date、Optional、Dictionary等类型扩展
- 🌐 **网络请求**：基于Alamofire和Combine的网络请求封装
- 💾 **数据存储**：UserDefaults、Keychain、Cache等存储方案
- 🛠️ **工具库**：日志、权限管理、设备信息、加密等常用工具
- 🖼️ **图片处理**：图片加载、缓存、处理等功能
- 🌍 **多语言**：多语言管理功能

## 📦 模块说明

### SwiftComponentKitUI
UI组件库，提供常用的UI扩展和组件：
- UIColor、UIView、UIButton、UILabel等扩展
- Alert、Toast、Loading、EmptyState等组件
- UIViewController扩展（状态栏、导航栏、键盘管理等）
- 下拉刷新和上拉加载组件

### SwiftComponentKitFoundation
Foundation扩展库，提供常用的Foundation类型扩展：
- Optional包装（wrapEmpty、wrapZero等）
- Date和String转换
- String验证（邮箱、手机号、URL等）
- 屏幕尺寸和App信息获取

### SwiftComponentKitImage
图片处理库，提供图片处理、加载和缓存功能：
- UIImage处理扩展
- UIImageView加载和缓存
- 图片缓存管理

### SwiftComponentKitNetwork
网络请求库，基于Alamofire和Combine的网络请求封装：
- 标准响应格式封装
- 请求拦截器
- 响应拦截器
- 错误处理

### SwiftComponentKitStorage
数据存储库，提供UserDefaults、Keychain、数据库等存储方案：
- UserDefaults封装
- Keychain封装
- 内存缓存

### SwiftComponentKitUtils
工具库，提供日志、权限、加密等常用工具：
- 日志管理
- 权限管理
- 设备信息
- 加密工具
- 文件管理
- JSON处理
- 定时器
- 通知中心

### SwiftComponentKitLocalization
多语言库，提供多语言管理功能。

## 🚀 安装

### 方式一：CocoaPods（推荐）

#### 选项 A：分别引用各个子模块（推荐）

在项目的 `Podfile` 中添加：

```ruby
target 'YourProject' do
  use_frameworks!
  
  # MARK: - SwiftComponentKit（按需引入）
  # UI组件库
  pod 'SwiftComponentKitUI', :path => './SwiftComponentKit/SwiftComponentKitUI'
  
  # Foundation扩展库
  pod 'SwiftComponentKitFoundation', :path => './SwiftComponentKit/SwiftComponentKitFoundation'
  
  # 图片处理库
  pod 'SwiftComponentKitImage', :path => './SwiftComponentKit/SwiftComponentKitImage'
  
  # 网络请求库
  pod 'SwiftComponentKitNetwork', :path => './SwiftComponentKit/SwiftComponentKitNetwork'
  
  # 数据存储库
  pod 'SwiftComponentKitStorage', :path => './SwiftComponentKit/SwiftComponentKitStorage'
  
  # 工具库
  pod 'SwiftComponentKitUtils', :path => './SwiftComponentKit/SwiftComponentKitUtils'
  
  # 多语言库
  pod 'SwiftComponentKitLocalization', :path => './SwiftComponentKit/SwiftComponentKitLocalization'
end
```

然后运行：

```bash
pod install
```

#### 选项 B：使用主 Podspec（聚合所有子模块）

```ruby
# 使用所有模块
pod 'SwiftComponentKit', :path => './SwiftComponentKit'

# 或只使用需要的模块
pod 'SwiftComponentKit/UI', :path => './SwiftComponentKit'
pod 'SwiftComponentKit/Foundation', :path => './SwiftComponentKit'
```

### 方式二：Swift Package Manager (SPM)

#### 本地路径集成（无需发布）

1. 在 Xcode 中选择项目文件（蓝色图标）
2. **重要**：先选择主 Target，这样添加 Package 时会默认选中该 Target
3. 点击 **"Package Dependencies"** 标签
4. 点击 **"+"** 按钮
5. 选择 **"Add Local..."**
6. 浏览并选择 `SwiftComponentKit` 目录
7. 在 "Add to Target" 中，勾选主 Target
8. 在 "Package Products" 中，勾选需要的模块
9. 点击 **"Add Package"**

#### 远程仓库集成（推荐）

1. 在 Xcode 中选择项目文件（蓝色图标）
2. 选择主 Target
3. 点击 **"Package Dependencies"** 标签
4. 点击 **"+"** 按钮
5. 在搜索框中输入：`https://github.com/mokong/SwiftComponentKit.git`
6. 选择 **"Add Package"**
7. 选择版本规则（推荐选择 "Up to Next Major Version" 并输入 `1.0.0`）
8. 在 "Add to Target" 中，勾选主 Target
9. 在 "Package Products" 中，勾选需要的模块：
   - `SwiftComponentKitUI`
   - `SwiftComponentKitFoundation`
   - `SwiftComponentKitImage`
   - `SwiftComponentKitNetwork`
   - `SwiftComponentKitStorage`
   - `SwiftComponentKitUtils`
   - `SwiftComponentKitLocalization`
10. 点击 **"Add Package"**

**注意**：首次使用需要确保已创建并推送 Git 标签（tag），例如：
```bash
git tag -a 1.0.0 -m "Release version 1.0.0"
git push origin 1.0.0
```

## 📖 使用示例

### 1. UI组件

```swift
import SwiftComponentKitUI

// UIColor - HexString创建颜色
let color1 = UIColor(sck_hexString: "#FF0000")
let color2 = UIColor(sck_hexString: "FF0000")
let color3 = UIColor(sck_hexString: "0xFF0000")

// UIView - 渐变背景
view.sck_setGradientBackground(
    colors: [.red, .blue],
    direction: .horizontal,  // 或 .vertical, .diagonalTopLeft, .diagonalTopRight
    locations: [0.0, 1.0],
    cornerRadius: 10
)

// UIView - 动画
view.sck_fadeIn(duration: 0.3) {
    print("淡入完成")
}
view.sck_shake()  // 震动动画

// UIView - 分割线
view.sck_addBottomDivider(color: .gray, height: 1.0, leftMargin: 20, rightMargin: 20)

// UIButton - 图片位置
button.sck_setImagePosition(.top, spacing: 10)  // 图片在上，文字在下

// UILabel - 行间距
label.sck_setLineSpacing(5, text: "这是一段文字\n这是第二行")

// Alert
SCKAlert.show(
    title: "提示",
    message: "这是一个提示消息",
    actions: [
        SCKAlertAction(title: "取消", style: .cancel) {
            print("取消")
        },
        SCKAlertAction(title: "确定", style: .default) {
            print("确定")
        }
    ]
)

// Toast
SCKToast.show("操作成功", duration: 2.0)
SCKToast.show("加载完成", duration: 3.0, position: .bottom, in: view)

// Loading
SCKLoadingIndicator.show(in: view, message: "加载中...")
SCKLoadingIndicator.hide()

// EmptyState
SCKEmptyStateView.show(
    in: view,
    image: UIImage(named: "empty"),
    title: "暂无数据",
    message: "请稍后再试"
)

// UIViewController扩展
class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 状态栏设置
        sck_statusBarHidden = false
        sck_statusBarStyle = .lightContent
        
        // 导航栏设置
        sck_navigationBarHidden = true
        
        // 侧滑返回设置
        sck_swipeBackEnabled = true
        sck_swipeBackInterceptor = {
            return self.canGoBack()
        }
        
        // 键盘管理
        sck_addKeyboardObserver()
        sck_keyboardWillShow = { frame in
            print("键盘高度: \(frame.height)")
        }
        sck_hideKeyboardWhenTappedAround()
    }
    
    deinit {
        sck_removeKeyboardObserver()
    }
}

// 获取当前视图控制器
if let currentVC = UIViewController.sck_current() {
    print("当前VC: \(currentVC)")
}
```

### 2. Foundation扩展

```swift
import SwiftComponentKitFoundation

// Optional包装
let value: String? = nil
let result = value.sck_wrapEmpty  // ""

let intValue: Int? = nil
let intResult = intValue.sck_wrapZero  // 0

// Date转String
let date = Date()
let dateString = date.sck_toString(format: "yyyy-MM-dd HH:mm:ss")
let utcString = date.sck_toStringUTC(format: "yyyy-MM-dd")

// String转Date
let dateFromString = "2021-01-01".sck_toDate(format: "yyyy-MM-dd")

// 时间戳转Date
let dateFromTimestamp = Date.sck_fromTimestamp(1609459200)
let dateFromMilliseconds = Date.sck_fromMilliseconds(1609459200000)

// App信息
let version = String.sck_appVersion
let buildVersion = String.sck_appBuildVersion
let appName = String.sck_appName
let bundleID = String.sck_appBundleID

// 屏幕信息
let width = CGFloat.sck_screenWidth
let height = CGFloat.sck_screenHeight
let statusBarH = CGFloat.sck_statusBarHeight
let navBarH = CGFloat.sck_navigationBarHeight
let tabBarH = CGFloat.sck_tabBarHeight
let safeAreaTop = CGFloat.sck_safeAreaTop
let safeAreaBottom = CGFloat.sck_safeAreaBottom

// String验证
let email = "example@example.com"
if email.sck_isValidEmail {
    print("有效邮箱")
}

let phone = "13800138000"
if phone.sck_isValidPhone {
    print("有效手机号")
}

let url = "https://www.example.com"
if url.sck_isValidURL {
    print("有效URL")
}

// String处理
let str = "  hello world  "
let trimmed = str.sck_trimmed  // "hello world"
let reversed = str.sck_reversed  // "  dlrow olleh  "
```

### 3. 网络请求

```swift
import SwiftComponentKitNetwork

// 定义响应模型
struct UserResponse: Codable {
    let id: Int
    let name: String
}

// 发起请求
SCKNetworkManager.shared.requestStandard(
    url: "https://api.example.com/user",
    method: .get
) { (result: Result<SCKStandardResponse<UserResponse>, SCKNetworkError>) in
    switch result {
    case .success(let response):
        if response.isSuccess {
            print("用户: \(response.data?.name ?? "")")
        } else {
            print("错误: \(response.message ?? "")")
        }
    case .failure(let error):
        print("网络错误: \(error)")
    }
}

// POST请求
SCKNetworkManager.shared.requestStandard(
    url: "https://api.example.com/user",
    method: .post,
    parameters: ["name": "John"],
    headers: ["Authorization": "Bearer token"]
) { (result: Result<SCKStandardResponse<UserResponse>, SCKNetworkError>) in
    // 处理结果
}

// 使用请求拦截器
let interceptor = SCKRequestInterceptor()
interceptor.add(MyCustomInterceptor())
```

### 4. 数据存储

```swift
import SwiftComponentKitStorage

// UserDefaults
SCKUserDefaults.standard.setString("value", forKey: "key")
let value = SCKUserDefaults.standard.getString(forKey: "key")

SCKUserDefaults.standard.setInt(100, forKey: "count")
let count = SCKUserDefaults.standard.getInt(forKey: "count")

// Keychain
SCKKeychain.set("secret", forKey: "token")
let token = SCKKeychain.get(forKey: "token")

SCKKeychain.delete(forKey: "token")

// Cache
SCKCache.shared.set("cachedValue", forKey: "cacheKey")
let cachedValue = SCKCache.shared.get(forKey: "cacheKey") as? String
SCKCache.shared.remove(forKey: "cacheKey")
SCKCache.shared.removeAll()
```

### 5. 工具库

```swift
import SwiftComponentKitUtils

// 日志
SCKLogger.info("信息")
SCKLogger.warning("警告")
SCKLogger.error("错误")
SCKLogger.debug("调试")

// 权限管理
SCKPermissionManager.requestPermission(.camera) { granted in
    if granted {
        print("相机权限已授予")
    }
}

SCKPermissionManager.requestPermission(.photoLibrary) { granted in
    // 处理权限结果
}

// 设备信息
let deviceInfo = SCKDeviceInfo.shared
print("设备型号: \(deviceInfo.model)")
print("设备名称: \(deviceInfo.name)")
print("系统版本: \(deviceInfo.systemVersion)")
print("是否为iPhone: \(deviceInfo.isiPhone)")
print("是否为模拟器: \(deviceInfo.isSimulator)")
print("屏幕宽度: \(deviceInfo.screenWidth)")
print("屏幕高度: \(deviceInfo.screenHeight)")

// 加密
let plainText = "Hello World"
let encrypted = SCKCrypto.encrypt(plainText, key: "secretKey")
let decrypted = SCKCrypto.decrypt(encrypted, key: "secretKey")

// JSON处理
let dict = ["name": "John", "age": 30]
let jsonString = SCKJSON.string(from: dict)
let parsedDict = SCKJSON.dictionary(from: jsonString)

// 定时器
let timer = SCKTimer.scheduledTimer(timeInterval: 1.0, repeats: true) {
    print("定时器触发")
}
timer.invalidate()

// 延迟执行
SCKTimer.after(2.0) {
    print("2秒后执行")
}

// 通知中心
SCKNotificationCenter.addObserver(name: "MyNotification") { notification in
    print("收到通知: \(notification)")
}

SCKNotificationCenter.post(name: "MyNotification", object: nil)
```

### 6. 图片处理

```swift
import SwiftComponentKitImage

// UIImageView加载图片
imageView.sck_setImage(url: "https://example.com/image.jpg", placeholder: UIImage(named: "placeholder"))

// UIImage处理
let resizedImage = image.sck_resize(to: CGSize(width: 100, height: 100))
let roundedImage = image.sck_rounded(cornerRadius: 10)
let croppedImage = image.sck_crop(to: CGRect(x: 0, y: 0, width: 100, height: 100))
```

### 7. 多语言

```swift
import SwiftComponentKitLocalization

// 使用多语言管理器
let localizedString = SCKLocalizationManager.shared.localizedString(forKey: "hello")
```

## 🔧 配置说明

### 依赖关系

- `SwiftComponentKitUI` → 依赖 `SnapKit` (~> 5.0)
- `SwiftComponentKitNetwork` → 依赖 `Alamofire` (~> 5.4)
- `SwiftComponentKitStorage` → 依赖 `SwiftComponentKitUtils` 和 `SwiftComponentKitFoundation`

### 平台要求

- **iOS**: 13.0+
- **Swift**: 5.0+
- **Xcode**: 12.0+

## ⚠️ 注意事项

1. **依赖冲突**：
   - 确保主项目的 `Alamofire` 版本与组件库兼容（5.4+）
   - 确保 `SnapKit` 版本兼容（5.0+）

2. **命名冲突**：
   - 所有扩展方法使用 `sck_` 前缀，避免冲突
   - 如果主项目有类似扩展，注意区分

3. **模块导入**：
   - 按需导入，避免导入不需要的模块
   - 某些模块之间有依赖关系，注意导入顺序

4. **编译设置**：
   - 确保主项目的 Swift 版本 >= 5.0
   - 确保 iOS 部署目标 >= 11.0

## 🐛 问题排查

### 问题1：pod install 失败

**解决方案**：
```bash
# 清理缓存
pod cache clean --all
pod deintegrate
pod install
```

### 问题2：编译错误 - 找不到模块

**解决方案**：
1. 检查 Podfile 路径是否正确
2. 确保 podspec 文件存在
3. 重新运行 `pod install`

### 问题3：依赖冲突

**解决方案**：
1. 检查主项目的依赖版本
2. 确保版本兼容
3. 使用 `pod update` 更新依赖

### 问题4：SPM 集成后找不到模块

**解决方案**：
1. 确保已正确添加 Package Dependencies
2. 检查 Target 是否正确勾选
3. 清理构建文件夹（Shift+Cmd+K）后重新编译

## ⚠️ 重要提示：避免代码重复

如果多个项目都使用**本地路径**方式导入组件库，会导致代码重复和维护困难。

**推荐方案**：
- 🏢 **多项目共享**：使用 [Git Submodule](./BEST_PRACTICES.md#方案一git-submodule推荐用于多项目共享)
- 🌐 **公开发布**：使用 [SPM 远程仓库](./BEST_PRACTICES.md#方案二spm-远程仓库推荐用于公开发布)
- 🏛️ **企业内部分享**：使用 [CocoaPods 私有仓库](./BEST_PRACTICES.md#方案三cocoapods-私有仓库推荐用于企业内部分享)

详细说明请查看：[最佳实践指南](./BEST_PRACTICES.md)


## 📄 许可证

MIT License

Copyright (c) 2026 SwiftComponentKit

## 👥 贡献

欢迎提交 Issue 和 Pull Request！

### 贡献指南

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

---

## 📞 联系方式

如有问题或建议，请通过以下方式联系：
- 提交 [Issue](https://github.com/mokong/SwiftComponentKit/issues)
- 创建 [Pull Request](https://github.com/mokong/SwiftComponentKit/pulls)

---

**⭐ 如果这个项目对你有帮助，请给个 Star！**

