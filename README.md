# SwiftComponentKit

**English** | [中文](README.zh.md)

[![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-13.0+-blue.svg)](https://www.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A comprehensive Swift component library collection providing commonly used UI components, Foundation extensions, network requests, data storage, and more. Designed with a modular architecture, allowing on-demand integration to reduce package size.

## ✨ Features

- 🎨 **UI Components**: Alert, Toast, Loading, EmptyState, Refresh, and other commonly used components
- 🔧 **Foundation Extensions**: Extensions for String, Date, Optional, Dictionary, and other types
- 🌐 **Network Requests**: Network request wrapper based on Alamofire and Combine
- 💾 **Data Storage**: Storage solutions including UserDefaults, Keychain, Cache, etc.
- 🛠️ **Utilities**: Common utilities for logging, permission management, device information, encryption, etc.
- 🖼️ **Image Processing**: Image loading, caching, and processing functionality
- 🌍 **Localization**: Multi-language management functionality

## 📦 Module Overview

### SwiftComponentKitUI
UI component library providing commonly used UI extensions and components:
- Extensions for UIColor, UIView, UIButton, UILabel, etc.
- Components: Alert, Toast, Loading, EmptyState, etc.
- UIViewController extensions (status bar, navigation bar, keyboard management, etc.)
- Pull-to-refresh and load-more components

### SwiftComponentKitFoundation
Foundation extension library providing commonly used Foundation type extensions:
- Optional wrapping (wrapEmpty, wrapZero, etc.)
- Date and String conversion
- String validation (email, phone number, URL, etc.)
- Screen size and App information retrieval

### SwiftComponentKitImage
Image processing library providing image processing, loading, and caching functionality:
- UIImage processing extensions
- UIImageView loading and caching
- Image cache management

### SwiftComponentKitNetwork
Network request library, a wrapper based on Alamofire and Combine:
- Standard response format encapsulation
- Request interceptors
- Response interceptors
- Error handling

### SwiftComponentKitStorage
Data storage library providing storage solutions including UserDefaults, Keychain, and cache:
- UserDefaults wrapper
- Keychain wrapper
- Memory cache

### SwiftComponentKitUtils
Utility library providing common utilities for logging, permissions, encryption, etc.:
- Logging management
- Permission management
- Device information
- Encryption utilities
- File management
- JSON processing
- Timer
- Notification center

### SwiftComponentKitLocalization
Localization library providing multi-language management functionality.

## 🚀 Installation

### Option 1: CocoaPods (Recommended)

#### Option A: Reference Individual Submodules (Recommended)

Add to your project's `Podfile`:

```ruby
target 'YourProject' do
  use_frameworks!
  
  # MARK: - SwiftComponentKit (Import as needed)
  # UI Component Library
  pod 'SwiftComponentKitUI', :path => './SwiftComponentKit/SwiftComponentKitUI'
  
  # Foundation Extension Library
  pod 'SwiftComponentKitFoundation', :path => './SwiftComponentKit/SwiftComponentKitFoundation'
  
  # Image Processing Library
  pod 'SwiftComponentKitImage', :path => './SwiftComponentKit/SwiftComponentKitImage'
  
  # Network Request Library
  pod 'SwiftComponentKitNetwork', :path => './SwiftComponentKit/SwiftComponentKitNetwork'
  
  # Data Storage Library
  pod 'SwiftComponentKitStorage', :path => './SwiftComponentKit/SwiftComponentKitStorage'
  
  # Utility Library
  pod 'SwiftComponentKitUtils', :path => './SwiftComponentKit/SwiftComponentKitUtils'
  
  # Localization Library
  pod 'SwiftComponentKitLocalization', :path => './SwiftComponentKit/SwiftComponentKitLocalization'
end
```

Then run:

```bash
pod install
```

#### Option B: Use Main Podspec (Aggregates All Submodules)

```ruby
# Use all modules
pod 'SwiftComponentKit', :path => './SwiftComponentKit'

# Or use only needed modules
pod 'SwiftComponentKit/UI', :path => './SwiftComponentKit'
pod 'SwiftComponentKit/Foundation', :path => './SwiftComponentKit'
```

### Option 2: Swift Package Manager (SPM)

#### Local Path Integration (No Publishing Required)

1. In Xcode, select the project file (blue icon)
2. **Important**: Select the main Target first, so the Package will be added to this Target by default
3. Click the **"Package Dependencies"** tab
4. Click the **"+"** button
5. Select **"Add Local..."**
6. Browse and select the `SwiftComponentKit` directory
7. In "Add to Target", check the main Target
8. In "Package Products", check the modules you need
9. Click **"Add Package"**

#### Remote Repository Integration (Recommended)

1. In Xcode, select the project file (blue icon)
2. Select the main Target
3. Click the **"Package Dependencies"** tab
4. Click the **"+"** button
5. Enter in the search box: `https://github.com/mokong/SwiftComponentKit.git`
6. Select **"Add Package"**
7. Choose version rule (recommended: select "Up to Next Major Version" and enter `1.0.0`)
8. In "Add to Target", check the main Target
9. In "Package Products", check the modules you need:
   - `SwiftComponentKitUI`
   - `SwiftComponentKitFoundation`
   - `SwiftComponentKitImage`
   - `SwiftComponentKitNetwork`
   - `SwiftComponentKitStorage`
   - `SwiftComponentKitUtils`
   - `SwiftComponentKitLocalization`
10. Click **"Add Package"**

**Note**: For first-time use, ensure Git tags have been created and pushed, for example:
```bash
git tag -a 1.0.0 -m "Release version 1.0.0"
git push origin 1.0.0
```

## 📖 Usage Examples

### 1. UI Components

```swift
import SwiftComponentKitUI

// UIColor - Create color from HexString
let color1 = UIColor(sck_hexString: "#FF0000")
let color2 = UIColor(sck_hexString: "FF0000")
let color3 = UIColor(sck_hexString: "0xFF0000")

// UIView - Gradient background
view.sck_setGradientBackground(
    colors: [.red, .blue],
    direction: .horizontal,  // or .vertical, .diagonalTopLeft, .diagonalTopRight
    locations: [0.0, 1.0],
    cornerRadius: 10
)

// UIView - Animations
view.sck_fadeIn(duration: 0.3) {
    print("Fade in completed")
}
view.sck_shake()  // Shake animation

// UIView - Divider
view.sck_addBottomDivider(color: .gray, height: 1.0, leftMargin: 20, rightMargin: 20)

// UIButton - Image position
button.sck_setImagePosition(.top, spacing: 10)  // Image on top, text below

// UILabel - Line spacing
label.sck_setLineSpacing(5, text: "This is a line\nThis is the second line")

// Alert
SCKAlert.show(
    title: "Alert",
    message: "This is an alert message",
    actions: [
        SCKAlertAction(title: "Cancel", style: .cancel) {
            print("Cancelled")
        },
        SCKAlertAction(title: "OK", style: .default) {
            print("Confirmed")
        }
    ]
)

// Toast
SCKToast.show("Operation successful", duration: 2.0)
SCKToast.show("Loading completed", duration: 3.0, position: .bottom, in: view)

// Loading
SCKLoadingIndicator.show(in: view, message: "Loading...")
SCKLoadingIndicator.hide()

// EmptyState
SCKEmptyStateView.show(
    in: view,
    image: UIImage(named: "empty"),
    title: "No Data",
    message: "Please try again later"
)

// UIViewController Extensions
class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status bar settings
        sck_statusBarHidden = false
        sck_statusBarStyle = .lightContent
        
        // Navigation bar settings
        sck_navigationBarHidden = true
        
        // Swipe back settings
        sck_swipeBackEnabled = true
        sck_swipeBackInterceptor = {
            return self.canGoBack()
        }
        
        // Keyboard management
        sck_addKeyboardObserver()
        sck_keyboardWillShow = { frame in
            print("Keyboard height: \(frame.height)")
        }
        sck_hideKeyboardWhenTappedAround()
    }
    
    deinit {
        sck_removeKeyboardObserver()
    }
}

// Get current view controller
if let currentVC = UIViewController.sck_current() {
    print("Current VC: \(currentVC)")
}
```

### 2. Foundation Extensions

```swift
import SwiftComponentKitFoundation

// Optional wrapping
let value: String? = nil
let result = value.sck_wrapEmpty  // ""

let intValue: Int? = nil
let intResult = intValue.sck_wrapZero  // 0

// Date to String
let date = Date()
let dateString = date.sck_toString(format: "yyyy-MM-dd HH:mm:ss")
let utcString = date.sck_toStringUTC(format: "yyyy-MM-dd")

// String to Date
let dateFromString = "2021-01-01".sck_toDate(format: "yyyy-MM-dd")

// Timestamp to Date
let dateFromTimestamp = Date.sck_fromTimestamp(1609459200)
let dateFromMilliseconds = Date.sck_fromMilliseconds(1609459200000)

// App information
let version = String.sck_appVersion
let buildVersion = String.sck_appBuildVersion
let appName = String.sck_appName
let bundleID = String.sck_appBundleID

// Screen information
let width = CGFloat.sck_screenWidth
let height = CGFloat.sck_screenHeight
let statusBarH = CGFloat.sck_statusBarHeight
let navBarH = CGFloat.sck_navigationBarHeight
let tabBarH = CGFloat.sck_tabBarHeight
let safeAreaTop = CGFloat.sck_safeAreaTop
let safeAreaBottom = CGFloat.sck_safeAreaBottom

// String validation
let email = "example@example.com"
if email.sck_isValidEmail {
    print("Valid email")
}

let phone = "13800138000"
if phone.sck_isValidPhone {
    print("Valid phone number")
}

let url = "https://www.example.com"
if url.sck_isValidURL {
    print("Valid URL")
}

// String processing
let str = "  hello world  "
let trimmed = str.sck_trimmed  // "hello world"
let reversed = str.sck_reversed  // "  dlrow olleh  "
```

### 3. Network Requests

```swift
import SwiftComponentKitNetwork

// Define response model
struct UserResponse: Codable {
    let id: Int
    let name: String
}

// Make request
SCKNetworkManager.shared.requestStandard(
    url: "https://api.example.com/user",
    method: .get
) { (result: Result<SCKStandardResponse<UserResponse>, SCKNetworkError>) in
    switch result {
    case .success(let response):
        if response.isSuccess {
            print("User: \(response.data?.name ?? "")")
        } else {
            print("Error: \(response.message ?? "")")
        }
    case .failure(let error):
        print("Network error: \(error)")
    }
}

// POST request
SCKNetworkManager.shared.requestStandard(
    url: "https://api.example.com/user",
    method: .post,
    parameters: ["name": "John"],
    headers: ["Authorization": "Bearer token"]
) { (result: Result<SCKStandardResponse<UserResponse>, SCKNetworkError>) in
    // Handle result
}

// Use request interceptor
let interceptor = SCKRequestInterceptor()
interceptor.add(MyCustomInterceptor())
```

### 4. Data Storage

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

### 5. Utilities

```swift
import SwiftComponentKitUtils

// Logging
SCKLogger.info("Info")
SCKLogger.warning("Warning")
SCKLogger.error("Error")
SCKLogger.debug("Debug")

// Permission management
SCKPermissionManager.requestPermission(.camera) { granted in
    if granted {
        print("Camera permission granted")
    }
}

SCKPermissionManager.requestPermission(.photoLibrary) { granted in
    // Handle permission result
}

// Device information
let deviceInfo = SCKDeviceInfo.shared
print("Device model: \(deviceInfo.model)")
print("Device name: \(deviceInfo.name)")
print("System version: \(deviceInfo.systemVersion)")
print("Is iPhone: \(deviceInfo.isiPhone)")
print("Is Simulator: \(deviceInfo.isSimulator)")
print("Screen width: \(deviceInfo.screenWidth)")
print("Screen height: \(deviceInfo.screenHeight)")

// Encryption
let plainText = "Hello World"
let encrypted = SCKCrypto.encrypt(plainText, key: "secretKey")
let decrypted = SCKCrypto.decrypt(encrypted, key: "secretKey")

// JSON processing
let dict = ["name": "John", "age": 30]
let jsonString = SCKJSON.string(from: dict)
let parsedDict = SCKJSON.dictionary(from: jsonString)

// Timer
let timer = SCKTimer.scheduledTimer(timeInterval: 1.0, repeats: true) {
    print("Timer fired")
}
timer.invalidate()

// Delayed execution
SCKTimer.after(2.0) {
    print("Executed after 2 seconds")
}

// Notification center
SCKNotificationCenter.addObserver(name: "MyNotification") { notification in
    print("Received notification: \(notification)")
}

SCKNotificationCenter.post(name: "MyNotification", object: nil)
```

### 6. Image Processing

```swift
import SwiftComponentKitImage

// UIImageView load image
imageView.sck_setImage(url: "https://example.com/image.jpg", placeholder: UIImage(named: "placeholder"))

// UIImage processing
let resizedImage = image.sck_resize(to: CGSize(width: 100, height: 100))
let roundedImage = image.sck_rounded(cornerRadius: 10)
let croppedImage = image.sck_crop(to: CGRect(x: 0, y: 0, width: 100, height: 100))
```

### 7. Localization

```swift
import SwiftComponentKitLocalization

// Use localization manager
let localizedString = SCKLocalizationManager.shared.localizedString(forKey: "hello")
```

## 🔧 Configuration

### Dependencies

- `SwiftComponentKitUI` → depends on `SnapKit` (~> 5.0)
- `SwiftComponentKitNetwork` → depends on `Alamofire` (~> 5.4)
- `SwiftComponentKitStorage` → depends on `SwiftComponentKitUtils` and `SwiftComponentKitFoundation`

### Platform Requirements

- **iOS**: 13.0+
- **Swift**: 5.0+
- **Xcode**: 12.0+

## ⚠️ Notes

1. **Dependency Conflicts**:
   - Ensure the main project's `Alamofire` version is compatible (5.4+)
   - Ensure `SnapKit` version is compatible (5.0+)

2. **Naming Conflicts**:
   - All extension methods use the `sck_` prefix to avoid conflicts
   - If the main project has similar extensions, be careful to distinguish them

3. **Module Imports**:
   - Import on demand, avoid importing unnecessary modules
   - Some modules have dependencies, pay attention to import order

4. **Build Settings**:
   - Ensure the main project's Swift version >= 5.0
   - Ensure iOS deployment target >= 13.0

## 🐛 Troubleshooting

### Issue 1: pod install fails

**Solution**:
```bash
# Clean cache
pod cache clean --all
pod deintegrate
pod install
```

### Issue 2: Build error - Module not found

**Solution**:
1. Check if the Podfile path is correct
2. Ensure podspec files exist
3. Run `pod install` again

### Issue 3: Dependency conflicts

**Solution**:
1. Check the main project's dependency versions
2. Ensure version compatibility
3. Use `pod update` to update dependencies

### Issue 4: Module not found after SPM integration

**Solution**:
1. Ensure Package Dependencies are correctly added
2. Check if the Target is correctly selected
3. Clean build folder (Shift+Cmd+K) and rebuild

## ⚠️ Important: Avoid Code Duplication

If multiple projects use the **local path** method to import the component library, it will lead to code duplication and maintenance difficulties.

**Recommended Solutions**:
- 🏢 **Multi-project Sharing**: Use [Git Submodule](./BEST_PRACTICES.md#方案一git-submodule推荐用于多项目共享)
- 🌐 **Public Release**: Use [SPM Remote Repository](./BEST_PRACTICES.md#方案二spm-远程仓库推荐用于公开发布)
- 🏛️ **Enterprise Internal Sharing**: Use [CocoaPods Private Repository](./BEST_PRACTICES.md#方案三cocoapods-私有仓库推荐用于企业内部分享)

For detailed instructions, see: [Best Practices Guide](./BEST_PRACTICES.md)

## 📄 License

MIT License

Copyright (c) 2026 SwiftComponentKit

## 👥 Contributing

Issues and Pull Requests are welcome!

### Contribution Guidelines

1. Fork this repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📞 Contact

For questions or suggestions, please contact us through:
- Submit an [Issue](https://github.com/mokong/SwiftComponentKit/issues)
- Create a [Pull Request](https://github.com/mokong/SwiftComponentKit/pulls)

---

**⭐ If this project helps you, please give it a Star!**
