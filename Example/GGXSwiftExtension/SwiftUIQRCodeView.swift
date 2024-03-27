//
//  SwiftUIQRCodeView.swift
//  GGXSwiftExtension_Example
//
//  Created by 高广校 on 2024/3/5.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import GGXSwiftExtension

@available(iOS 13.0, *)
struct SwiftUIQRCodeView: View {
    
//    @State var qrcodeString: String
    
    @State var qrCodeImage: UIImage = (UIImage.createQRCode(model: QRCreateModel(text: "This is a qrcode",logo: "appLogo")) ?? UIImage())
    
    var body: some View {
        
        VStack {
            
            Button(action: {
                testDevice()
            }, label: {
                Text("设备信息")
            })
            
            Button(action: {
                testApplication()
            }, label: {
                Text("UIApplication")
            })
        }
        
    }
    
    func testApplication () {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let windowscreen = windowScene?.screen
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
        print("notchValue: \(notchValue)")
        print("isIPhone: \(isPhoneX)")
    }
    
}

@available(iOS 13.0, *)
#Preview {
    SwiftUIQRCodeView()
}
