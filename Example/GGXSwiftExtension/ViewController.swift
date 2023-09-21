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
        
        //String扩展
//        stringToURL()
        
        //
        dictExtension()
        
//        UIApplication.rootWindow?.window
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

