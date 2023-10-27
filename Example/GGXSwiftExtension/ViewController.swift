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
//       testDevice()
        //6、音频base64
//        let filePath = Bundle.main.path(forResource: "20230919093347", ofType: "wav") ?? ""
//        let fileData = filePath.toFileUrl?.base64FileData
//        print(fileData)
        
        let m = ""
        print(m.isValidPhoneNumber())
        
        
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

