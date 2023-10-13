//
//  GGXSwiftExtension_ExampleTests.swift
//  GGXSwiftExtension_ExampleTests
//
//  Created by 高广校 on 2023/9/22.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import GGXSwiftExtension

final class GGXSwiftExtension_ExampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDevice(){
        print("导航栏高度\(TopBarHeight)")
        print("状态栏高度\(StatusBarHeight)")
        print("底部安全域\(BOTTOM_MARGIN)")
        print("设备型号\(UIDevice.modelName)")
        
        print("宽度：" + "\(SCREEN_WIDTH)")
        print("高度：" + "\(SCREEN_HEIGHT)")
        print("缩放因子：" + "\(SCREEN_SCALE)")
    }
    
    func testJSONfileToStr() {
        let d = Bundle.jsonfileTojson("JSBridgeAPITest")
        print(d)
    }

}
