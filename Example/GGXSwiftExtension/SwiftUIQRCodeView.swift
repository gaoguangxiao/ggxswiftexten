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
            Text("qrcode")

            Image(uiImage: qrCodeImage)
            
            Button(action: {
                isho()
            }, label: {
                Text("isphone")
            })
        }
        
    }
    
    func isho() {
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
