//
//  ViewController.swift
//  GGXSwiftExtension
//
//  Created by 小修 on 09/21/2023.
//  Copyright (c) 2023 小修. All rights reserved.
//

import UIKit
import GGXSwiftExtension

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
        
        //4、json文件解析
        let d = jsonfileTojsonStr()
        print(d)
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

    func jsonfileTojsonStr() -> Any {
        return Bundle.jsonfileTojson("JSBridgeAPITest")
        //将JSON文件 读取并输出为字符串
//        let filePath = Bundle.main.path(forResource: "JSBridgeAPITest", ofType: "json") ?? ""
//        guard let uurl = filePath.toFileUrl else {
//            print("URL为空")
//            return ""
//        }
//        //将文件数据转化为Data
//        let fileData = try? Data(contentsOf: uurl)
//        guard let fData = fileData else {
//            print("解析数据失败")
//            return ""
//        }
//
//        do {
//            let json = try JSONSerialization.jsonObject(with: fData)
//            return json
//        } catch {
//            print("json报错")
//            return ""
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

