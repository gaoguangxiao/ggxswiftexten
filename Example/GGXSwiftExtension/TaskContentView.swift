////
////  ContentView.swift
////  FailureTryable
////
////  Created by 高广校 on 2024/7/20.
////
//
//import SwiftUI
//import SmartCodable
//import GGXSwiftExtension
//
//struct ReponseModel: SmartCodable {
//    var code: Int = -1
//    var data: String?
//    var isSuccess: Bool = false
//    init() {
//        
//    }
//    init(code: Int, data: String, isSuccess: Bool) {
//        self.code = code
//        self.data = data
//        self.isSuccess = isSuccess
//    }
//}
//
//@available(iOS 13.0, *)
//class ContentViewModel: ObservableObject {
//    
//    @Published var isSuccess = false
//    
//    @Published var msg = ""
//    
//    @Published var msg2 = ""
//    
//    func netFunc()  {
//        isSuccess = false
//        let retryAdapter = GxRetryAdapter<Any>()
//        retryAdapter.failedCount = 0
//        //实际要执行的任务，需要闭包包装
//        retryAdapter.execute {
//            let r = await self.requestApi(paras: "1")
//            guard r else { return r }
//            self.isSuccess = r
//            return true
//        }
//    }
//    
//    func netFunc1()  {
//        msg = "无消息"
//        let retryAdapter = GxRetryAdapter<ReponseModel>()
//        retryAdapter.failedCount = 0 //重置可失败数
//        retryAdapter.task {
//            let r = await self.requestModelApi(paras: "1")
//            guard r.isSuccess else {
//                return .failure(FailureReason.CustomError)
//            }
//            return .success(r)
//        }.completeData { result in
//            switch result {
//            case .success(let success):
//                self.msg = "\(success.isSuccess),信息：\(success.toJSONString() ?? "")"
//            case .failure(let failure):
//                self.msg = failure.localizedDescription
//            }
//        }
//    }
//
//    func netFunc2() {
//        self.msg2 = ""
//        Task {
//            let result = await Task.retrying {
//                try await self.requestModelApiThrows(paras: "1")
//            }.result
//            switch result {
//            case .success(let success):
//                self.msg2 = "\(success.isSuccess),信息：\(success.toJSONString() ?? "")"
//            case .failure(let failure):
//                self.msg2 = failure.localizedDescription
//            }
//        }
//    }
//    
//    func netFunc3() {
//        self.msg2 = ""
//        Task {
//            let result = await Task.retrying { error in
//                //只有错误码为1才重试
//                let e = error as? ReponseError
//                return switch e {
//                    case .codeError:true
//                    default: false
//                }
//            } operation: {
//                try await self.requestModelApiThrows(paras: "1")
//            }.result
////            print("响应结果---")
//            switch result {
//            case .success(let success):
//                self.msg2 = "\(success.isSuccess),信息：\(success.toJSONString() ?? "")"
//            case .failure(let failure):
//                self.msg2 = failure.localizedDescription
//            }
//        }
//    }
//    func cancelFun2() {
//        
//    }
//}
//
//extension ContentViewModel {
//    
//    enum ReponseError: Int, Error, LocalizedError {
//        case codeError = 1
//        case codeError1
//        case codeError2
//        case codeError3
//        case codeError4
//        case codeError5
//    }
//    
//    /// 模拟网络请求
//    func requestApi(paras: String) async -> Bool {
//        let ran = Int.random(in: 0...3)
//        let b = ran == 1 ? true : false
//        print("发起网络结果---\(b)")
//        return b
//    }
//    
//    //复杂数据-code-data
//    func requestModelApi(paras: String) async -> ReponseModel {
//        let ran = Int.random(in: 0...3)
//        let b = ran == 1 ? true : false
//        let m = ReponseModel(code: ran, data: "12",isSuccess: b)
//        print("发起网络结果---\(m.code)")
//        return m
//    }
//    
//    
//    //抛出异常
//    func requestModelApiThrows(paras: String) async throws -> ReponseModel {
//        var code = Int.random(in: 0...2)
//        code = 1
//        let b = code == 0 ? true : false
//        print("发起网络结果---值：\(code)-是否成功：\(b)")
//        guard b else {
//            throw ReponseError(rawValue: code) ?? .codeError
//        }
//        let m = ReponseModel(code: code, data: "12",isSuccess: b)
//        return m
//    }
//    /// 模拟网络请求
//    func requestApi1(paras: String) async -> Bool {
//        print("发起网络---")
//        return false
//    }
//}
//
//struct TaskContentView: View {
//    
//    @StateObject var viewModel = ContentViewModel()
//    
//    var body: some View {
//        
//        Form {
//            Text("状态:\(viewModel.isSuccess)")
//            Button {
//                viewModel.netFunc()
//            } label: {
//                Text("网络可失败-bool")
//            }
//            
//            Section {
//                Text("状态:\(viewModel.msg)")
//                Button {
//                    viewModel.netFunc1()
//                } label: {
//                    Text("网络可失败-Model")
//                }
//            }
//            
//            Section {
//                Text("状态:\(viewModel.msg2)")
//                Button {
//                    viewModel.netFunc2()
//                } label: {
//                    Text("Task-任务封装")
//                }
//                
//                Button {
//                    viewModel.netFunc3()
//                } label: {
//                    Text("Task-任务封装-有条件的重试")
//                }
//                
//                Button {
//                    viewModel.netFunc2()
//                } label: {
//                    Text("网络可失败-取消")
//                }
//            }
//        }
//        VStack {
//            
//            
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    TaskContentView()
//}
