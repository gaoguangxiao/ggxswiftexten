//
//  UIApplication+CommonExtension.swift
//  DaDaClass
//
//  Created by problemchild on 2018/4/4.
//  Copyright © 2018年 dadaabc. All rights reserved.
//

import UIKit

@objc public extension UIApplication {
    @objc class var visibleViewController: UIViewController? {
        return UIApplication.getVisibleViewController(from: UIApplication.shared.keyWindow?.rootViewController)
    }

    @objc class func getVisibleViewController(from vc: UIViewController?) -> UIViewController? {
        if let nav = vc as? UINavigationController {
            return getVisibleViewController(from: nav.visibleViewController)
        } else if let tab = vc as? UITabBarController {
            return getVisibleViewController(from: tab.selectedViewController)
        } else if let pvc = vc?.presentedViewController {
            return getVisibleViewController(from: pvc)
        }
        return vc
    }

    /// build号 - 关于里面显示的版本号
    static var buildNumber: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }

    // 版本号 - 应用程序的版本号标识
    dynamic static var versionNumber: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    // AppName - APP装到手机里之后显示的名称
    static var displayName: String {
        return Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }
    
    static var bundleIdentifier: String {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? ""
    }

    static var appIcon: UIImage? {
        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last else { return nil }
        return UIImage(named: lastIcon)
    }
}
