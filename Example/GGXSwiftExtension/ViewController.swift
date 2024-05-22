//
//  ViewController.swift
//  GGXSwiftExtension
//
//  Created by 小修 on 09/21/2023.
//  Copyright (c) 2023 小修. All rights reserved.
//

import UIKit
import GGXSwiftExtension
import WebKit
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1、String扩展
        //        stringToURL()
        
        //2、
        //        dictExtension()
        //        3、
        //        UIApplication.rootWindow?.window
        
        //5、设备
               testDevice()
        //6、音频base64 if let 速记可将可选性展开同名的阴影变量
//        let filePath = Bundle.main.path(forResource: "20230919093347", ofType: "wav") ?? ""
//        let fileData = filePath.toFileUrl
//        if let fileData {
//            print(fileData)
//        }
        
        //7、文件MD5
        let filePath = Bundle.main.path(forResource: "lanlongbabu_2", ofType: "png") ?? ""
        let fileMD5 = filePath.toFileUrl?.toMD5()
        print(fileMD5)

    }
    
    @IBAction func 正则判断(_ sender: Any) {
        let phonenumber = "15737206051"
        print("是否是手机号\(phonenumber.isPhoneNunber)")
        
//        phonenumber.ranges(of: <#T##RegexComponent#>)
        //        邮箱
        //        let code = "11111"
        //        [rin]
        
        
        //        验证码匹配
        
        //URL
//        print("")
        //        let inputString = "Hello, Swift Regular Expressions!"
        //        let pattern = "swift"
        //        let replacement = "Regex"
        
        //        //举例代码
        //        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        //        regex?.enumerateMatches(in: inputString, range: NSRange(location: 0, length: inputString.count), using: { result, mflags, b in
        //
        //        })
        
        //        //在这个示例中 在`inputString`查找对应字符，并输出他们的位置
        //        if let matchs = inputString.matching(pattern: pattern) {
        //            for match in matchs {
        //                let matchRange = Range(match.range, in: inputString)!
        //                let matchedSubstring = inputString[matchRange]
        //                print("Matched substring: \(matchedSubstring) inrange.location\(match.range)")
        //            }
        //        }
        //
        //        //在这个示例中，我们将字符串 inputString 中的所有 "Swift" 替换为 "Regex"。
        //        if let modifiedString = inputString.replace(pattern: pattern, replacement: replacement) {
        //            print("Modified string: \(modifiedString)")
        //        }
        
    }
    
    
    @IBAction func 转屏(_ sender: Any) {
        //        if #available(iOS 13.0, *) {
        //            print(UIApplication.windowScenes)
        //        } else {
        //            // Fallback on earlier versions
        //        }
        //        //window
        //        if #available(iOS 15.0, *) {
        //            let window = UIApplication.windowScenes.first?.keyWindow
        //            print(window)
        //        } else {
        //            // Fallback on earlier versions
        //        }
        //        let window2 = UIApplication.rootWindow
        //
        //        print(window2)
        //    //        UIWindowScene
        
        if let app = UIApplication.shared.delegate as? AppDelegate {
            if app.orientationMask == .landscapeRight{
                app.orientationMask = .portrait
            } else  {
                app.orientationMask = .landscapeRight
            }
            self.p_switchOrientationWithLaunchScreen(orientation: app.orientationMask)
        }
    }
    
    func testDevice(){
        print("物理尺寸：" + "\(SCREEN_WIDTH)" + "*" + "\(SCREEN_HEIGHT)")
        print("缩放因子：" + "\(SCREEN_SCALE)")
        print("像素分辨率：" + "\(SCREEN_HEIGHT * SCREEN_SCALE)" + "*" + "\(SCREEN_WIDTH * SCREEN_SCALE)")
        
        print("导航栏高度\(TopBarHeight)")
        print("状态栏高度\(StatusBarHeight)")
        print("底部安全域\(BOTTOM_MARGIN)")
        print("设备型号\(UIDevice.modelName)")
        
        var isPhoneX = false
        let size = UIScreen.main.bounds.size// [UIScreen mainScreen].bounds.size;\
        let notchValue = size.width / size.height * 100;
        if notchValue == 216 || notchValue == 46 {
            isPhoneX = true
        }
        
        print("isIPhone: \(isPhoneX)")
    }
    
    
    func stringToURL() {
        //测试
        guard var urlStr = Bundle.main.path(forResource: "111", ofType: "mov") else { return }
        
        if let uurl = urlStr.toFileUrl {
            print(uurl)
        } else {
            print("失败")
        }
        
        urlStr = "http://www.baidu.com"
        let eUrl = urlStr.toUrl
        if let uEurl = eUrl {
            print("uEurl" , uEurl)
        }
    }
    
    func dictExtension() {
        let operateList = ["scope","oss"]
        let text = "text"
        let path = "//sadadadad"
        
        let dict : [String : Any] = ["operateList":operateList,
                                     "path":path,
                                     "text":text]
        
        let json = dict.toJsonString ?? ""
        print(json)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

