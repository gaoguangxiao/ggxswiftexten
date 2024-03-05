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

        Text("qrcode")

        Image(uiImage: qrCodeImage)
    }
    
}

@available(iOS 13.0, *)
#Preview {
    SwiftUIQRCodeView()
}
