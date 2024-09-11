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
            
            Button {
                testAudioFileMd5()
            } label: {
                Text("音频文件MD5")
            }

        }
        
    }
    
    func testAudioFileMd5() {
        let path = Bundle.main.url(forResource: "a9656f6b-df60-403a-977e-8962c2177544", withExtension: "mp3");
//        path?.toMD5()
        print("\(path?.toMD5())")
//        0.79470M、16.98867M、0.03095M
        let b = "3.59193M".toDiskSize()
        print(b)
    }
    
    func testApplication () {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let windowscreen = windowScene?.screen
    }
    
    func testDevice(){
        print("物理尺寸：" + "\(SCREEN_WIDTH)" + "*" + "\(SCREEN_HEIGHT)")
        print("缩放因子：" + "\(SCREEN_SCALE)")
        print("像素分辨率：" + "\(SCREEN_WIDTH * SCREEN_SCALE)" + "*" + "\(SCREEN_HEIGHT * SCREEN_SCALE)")
        
        print("导航栏高度\(TopBarHeight)")
        print("状态栏高度\(StatusBarHeight)")
        print("底部安全域\(BOTTOM_MARGIN)")
        print("设备型号\(UIDevice.modelName)")
        print("设备系统版本\(UIDevice.currentSystemVersion)")
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
 
extension String {
    mutating func addingEachRow() {
        var rows = self.components(separatedBy: .newlines)
        let header = rows.first?.csvEncoded()
        if let header = header {
            rows.insert(header, at: 0)
        }
        self = rows.joined(separator: "\n")
    }
    
    func csvEncoded() -> String {
        let doubleQuoteSet = CharacterSet(charactersIn: "\"")
        let commaSet = CharacterSet(charactersIn: ",")
        let newLineSet = CharacterSet(charactersIn: "\n")
        
        var output = self
            .replacingOccurrences(of: "\"", with: "\"\"")
            .replacingOccurrences(of: ",", with: ",\",\"")
        
        if output.rangeOfCharacter(from: doubleQuoteSet.union(commaSet).union(newLineSet)) != nil {
            output = "\"\(output)\""
        }
        return output
    }
}
