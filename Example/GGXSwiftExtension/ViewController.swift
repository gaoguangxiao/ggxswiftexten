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
        
        //5、导航栏高度
        
        //6、音频base64
        let filePath = Bundle.main.path(forResource: "20230919093347", ofType: "wav") ?? ""
        let fileData = filePath.toFileUrl?.base64FileData
        print(fileData)
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

