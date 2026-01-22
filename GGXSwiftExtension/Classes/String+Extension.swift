//
//  String+Extension.swift
//  wisdomstudy
//
//  Created by ggx on 2017/8/30.
//  Copyright © 2017年 高广校. All rights reserved.
//

import Foundation
import UIKit
import CryptoKit

import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

public extension String {
    var length: Int {
        return count
    }
    
    var range: NSRange {
        return NSRange(location: 0, length: count)
    }
    
    /// 预估尺寸，根据字体、宽度
    func size(font: UIFont, width: CGFloat = SCREEN_WIDTH_STATIC) -> CGSize {
        return (self as NSString).boundingRect(with: CGSize(width: width, height: CGFloat(HUGE)), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil).size
    }
    
    /// 预估尺寸，根据字体
    func size(of font: UIFont) -> CGSize {
        return self.boundingRect(with: CGSize(width: Double.greatestFiniteMagnitude, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size
    }
    
    /// 预估宽度，根据size
    func width(of font: UIFont, size: CGSize) -> Int {
        let boundingSize = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size
        let width = Int(boundingSize.width)
        return width + 1
    }
    
    /// 是否包含某个字符串
    func has(_ s: String) -> Bool {
        return range(of: s) != nil
    }
    
    /// 是否包含某个字符串
    /// - Parameters:
    ///   - s: 字符
    ///   - option: 匹配规则
    /// - Returns: <#description#>
    func has(_ s: String, option: String.CompareOptions) -> Bool {
        return range(of: s,options: option) != nil
//        return range(of: s) != nil
    }
    
    /// 分割字符
    func split(_ s: String) -> [String] {
        if s.isEmpty {
            return []
        }
        return components(separatedBy: s)
    }
    
//    func range(of searchString: String) -> NSRange {
//        return (self as NSString).range(of: searchString)
//    }
    
    func rangeOC(of searchString: String) -> NSRange {
        if let range = self.range(of: searchString, options: .caseInsensitive) {
            let nsrange = NSRange(range, in: self)
            return nsrange
        }
        return NSRange(location: 0, length: 0)
    }
    /// 去掉左右空格
    func trim() -> String {
        return trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func replace(_ old: String, new: String) -> String {
        return replacingOccurrences(of: old, with: new, options: NSString.CompareOptions.numeric, range: nil)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        return String(self[..<index(from: to)])
    }
    
    func index(from: Int) -> Index {
        return index(startIndex, offsetBy: from)
    }
    
    func substring(fromIndex: Int, toIndex: Int) -> String {
        let range = NSRange(location: fromIndex, length: toIndex - fromIndex)
        return substr(with: range)
    }
    
    func substr(with range: NSRange) -> String {
        let start = index(startIndex, offsetBy: range.location)
        let end = index(endIndex, offsetBy: range.location + range.length - count)
        return String(self[start..<end])
    }
    
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    func toInt64() -> Int64? {
        return Int64(self)
    }
    
    func toDouble() -> Double {
        return (Double(self) ?? 0)
    }
    
    var md5Value: String {
//        let data = self.data(using: .utf8)
//        Insecure.MD5.hash(data: data)
        if #available(iOS 13.0, *) {
            return Insecure.MD5.hash(data: self.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
        } else {
            // Fallback on earlier versions
            let length = Int(CC_MD5_DIGEST_LENGTH)
            var digest = [UInt8](repeating: 0, count: length)

                    if let d = self.data(using: .utf8) {
                        _ = d.withUnsafeBytes { body -> String in
                            CC_MD5(body.baseAddress, CC_LONG(d.count), &digest)

                            return ""
                        }
                    }

                    return (0 ..< length).reduce("") {
                        $0 + String(format: "%02x", digest[$1])
                    }
        }
    }
    
    //
    func toDiskSize() -> Double {
//        let byteCount = Double(self)
        let units = ["B", "K", "M", "G", "T", "P", "E", "Z", "Y"]
        //获取单位
        let lastStr = self.substring(from: self.length - 1)
        //获取数值
        var byteCount = Double(self.substring(to: self.length - 1)) ?? 0
        //
        var index = 0
        if let _index = units.firstIndex(of: lastStr) {
            index = _index;
        } else {
            if self.has("K") { index = 1
            } else if self.has("M") { index = 2
            } else if self.has("G") { index = 3
            } else if self.has("T") { index = 4
            } else if self.has("P") { index = 5
            } else if self.has("E") { index = 6
            }
        }
        
        while index > 0 {
            byteCount *= 1024
            index -= 1
        }
        return byteCount
    }
}

//MARK: 字符串操作
public extension String {

    static let random_str_characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    static let random_Int_characters = "0123456789"
    
    static func randomString(length : Int) -> String{
        var ranStr = ""
        for _ in 0..<length {
            let index = Int(arc4random_uniform(UInt32(random_str_characters.count)))
            ranStr.append(random_str_characters[random_str_characters.index(random_str_characters.startIndex, offsetBy: index)])
        }
        return ranStr
    }
    
    static func randomInt(length : Int) -> String{
        var ranStr = ""
        for _ in 0..<length {
            let index = Int(arc4random_uniform(UInt32(random_Int_characters.count)))
            ranStr.append(random_str_characters[random_Int_characters.index(random_Int_characters.startIndex, offsetBy: index)])
        }
        return ranStr
    }
}

// MARK: - URL Encode & Decode
public extension String {
        
    
    var encodeLocalOrRemoteForUrl: URL? {
        let canUseCache = FileManager.default.fileExists(atPath: self)
        var audioUrl: URL?
        if canUseCache {
            var fileUrl : URL?
            if #available(iOS 16.0, *) {
                fileUrl = URL(filePath: self)
            } else {
                // Fallback on earlier versions
                fileUrl = URL(fileURLWithPath: self)
            }
            audioUrl = fileUrl
        } else {
            guard let escapedURLString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                return nil
            }
            audioUrl = URL(string: escapedURLString)
        }
        return audioUrl
    }
    
    var toUrl: URL? {
        if let url = URL.init(string: self) {
            return url
        }
        let charSet = CharacterSet.urlQueryAllowed as NSCharacterSet
        let mutSet = charSet.mutableCopy() as! NSMutableCharacterSet
        mutSet.addCharacters(in: "#")
        let result = self.addingPercentEncoding(withAllowedCharacters: mutSet as CharacterSet)
        return URL(string: result ?? "")
    }
    
    var fileUrl: URL? {
        var url : URL?
        if #available(iOS 16.0, *) {
            url = URL(filePath: self)
        } else {
            // Fallback on earlier versions
            url = URL(fileURLWithPath: self)
        }
        return url
    }
    
    var toFileUrl: URL? {
        var url : URL?
        
        let charSet = CharacterSet.urlQueryAllowed as NSCharacterSet
        let mutSet = charSet.mutableCopy() as! NSMutableCharacterSet
        mutSet.addCharacters(in: "#")
        let result = self.addingPercentEncoding(withAllowedCharacters: mutSet as CharacterSet)
        
        if #available(iOS 16.0, *) {
            url = URL(filePath: result ?? "" )
        } else {
            // Fallback on earlier versions
            url = URL(fileURLWithPath: result ?? "")
        }
        return url
    }
    
    var URLEncode: String {
        let unreservedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
        let unreservedCharset = CharacterSet(charactersIn: unreservedChars)
        
        return addingPercentEncoding(withAllowedCharacters: unreservedCharset) ?? self
    }
    
    var URLDecode: String {
        return removingPercentEncoding ?? self
    }
    
    var URLAddingPercentEncodingInQuery: String {
        let allowedCharacters = CharacterSet.urlQueryAllowed
        return addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? self
    }
    
    var urlParamterEncode: String {
        func encodeParamterValue(paramter: String) -> String {
            let query = paramter.components(separatedBy: "=")
            guard query.count == 2 else { return paramter }
            let key: String = query.first ?? ""
            let value: String = query.last ?? ""
            let encodeParamter = "\(key)=\(value.URLEncode)"
            return encodeParamter
        }
        
        guard !self.isEmpty else { return self }
        let baseUrl = "?"
        guard self.contains(baseUrl) && (self.hasPrefix("https://") || self.hasPrefix("http://"))
        else { return self }
        
        let range = self.rangeOC(of: baseUrl)
        // get  "https://www.baidu.com?"
        let headerStrig = self.substring(to: range.location + range.length)
        // get key1=value1&key2=value2
        let paramterString = self.substring(from: range.location + range.length)
        // encode paramter
        var paramters = paramterString.components(separatedBy: "&")
        guard !paramters.isEmpty else { return self }
        for i in 0...paramters.count - 1 {
            var paramter = paramters[i]
            paramter = encodeParamterValue(paramter: paramter)
            paramters[i] = paramter
        }
        let encodeString = "\(paramters.joined(separator: "&"))"
        
        return "\(headerStrig)\(encodeString)"
    }
    
    var toPath: String {
        guard let url = self.toUrl else { return "" }
        if #available(iOS 16.0, *) {
            return url.path()
        } else {
            // Fallback on earlier versions
            return url.path
        }
    }
    
    var toHost: String? {
        guard let url = self.toUrl else { return "" }
        if #available(iOS 16.0, *) {
            return url.host()
        } else {
            // Fallback on earlier versions
            return url.host
        }
    }
        
    func getMIMETypeFromPathExtension() -> String {
        var MIMEType = "text/html"
        let pathExtension = self.pathExtension
        if pathExtension == "html" {
            MIMEType = "text/html"
        } else if pathExtension == "js"{
            MIMEType = "application/javascript";
        } else if pathExtension == "css"{
            MIMEType = "text/css";
        } else if pathExtension == "png"{
            MIMEType = "image/png"
        } else if pathExtension == "jpg"{
            MIMEType = "image/jpg"
        } else if pathExtension == "jpeg"{
            MIMEType = "image/jpeg"
        } else if pathExtension == "json"{
            MIMEType = "application/json"
        } else if pathExtension == "xml"{
            MIMEType = "application/xml"
        } else if pathExtension == "pdf"{
            MIMEType = "application/pdf"
        } else if pathExtension == "webp"{
            MIMEType = "image/webp"
        } else if pathExtension == "gif"{
            MIMEType = "application/gif"
        } else if pathExtension == "mp3"{
            MIMEType = "audio/mpeg"
        } else if pathExtension == "mp4"{
            MIMEType = "video/mp4"
        } else if pathExtension == "wav"{
            MIMEType = "audio/wav"
        } else if pathExtension == "ico"{
            MIMEType = "image/x-icon"
        } else if pathExtension == "svg"{
            MIMEType = "image/svg+xml"
        } else if pathExtension == "ttf"{
            MIMEType = "font/ttf"
        } else if pathExtension == "woff"{
            MIMEType = "font/woff"
        } else if pathExtension == "woff2"{
            MIMEType = "font/woff2"
        }
        return MIMEType;
    }
    
        
    //解析path路径
    func parsePushUrl() -> [String : String] {
        var result : [String : String] = [:]
        let comps = self.components(separatedBy: "&")
        for subUrl in comps {
            let subComps = subUrl.components(separatedBy: "=")
            if subComps.count == 2 {
                let key = subComps[0]
                result[key] = subComps[1].removingPercentEncoding
            }
        }
        return result
    }
}

// MARK: Function of NSString
public extension String {
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    var pathExtension: String {
        return (self as NSString).pathExtension
    }
    var stringByDeletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    var stringByDeletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    var pathComponents: [String] {
        return (self as NSString).pathComponents
    }
    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    func stringByAppendingPathExtension(ext: String) -> String? {
        let nsSt = self as NSString
        return nsSt.appendingPathExtension(ext)
    }
}

// MARK: 正则匹配
public extension String {

    /*
     
      https://www.jianshu.com/p/55d7c2d51d13
     
      ^  表示匹配字符串开始的位置（若干用在[]之外，则表示取反，表示不匹配括号中字符串）
      $  表示匹配字符串的结束位置
      [] 中括号表示 匹配括号中一个字符
      {} 大括号表示 限定匹配次数，如{n}代表匹配n个字符，{n,}表示至少匹配n个字母，{n,m}至少n,最多m
      \d 表示数字[0-9]，0-9的数字
      \D 表示非数字
     **/

    
    
//    ^1[0-9]{10}$ 或者 ^1\\d{10}$

    //匹配手机号
    //在Swift5.0原始字符串使用字符串插值时，必须反斜杠使用#号。Swift4.2需要转义反斜杠
    var isPhoneNunber: Bool {
//        return self.verification(pattern: "^1\\d{10}$")
        //swift5.0版本
        return self.verification(pattern: #"^1\d{10}$"#)
    }
    /// 核实合法手机号码
    func isValidPhoneNumber() -> Bool { self.verification(pattern: "^1\\d{10}$") }
    
    /// 验证字符串匹配结果是否符合要求，返回布尔值
    func verification(pattern: String) -> Bool { (self.matching(pattern: pattern)?.count ?? 0) > 0 }
    
    /// 获取匹配结果的数组
    func matching(pattern: String, options: NSRegularExpression.Options = .caseInsensitive) -> [NSTextCheckingResult]? {
        let regex = try? NSRegularExpression(pattern: pattern, options: options)
        return regex?.matches(in: self, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, self.count))
    }
    
//    func replaceNonEnglishCharactersWithSpaces(text: String) -> String {
//        let nonEnglishCharactersRange = NSMakeRange(0, text.utf16.count)
//        let regex = try! NSRegularExpression(pattern: "[^a-zA-Z]", options: [])
//        let modifiedString = regex.stringByReplacingMatches(in: text, options: [], range: nonEnglishCharactersRange, withTemplate: " ")
//        return modifiedString
//    }
    
    /// 替换字符
    func replace(pattern:String,replacement:String) -> String? {
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        return regex?.stringByReplacingMatches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count), withTemplate: replacement)
    }
   
}

//MARK: 图片base64
public extension String {
    /// 图片base64转Data数据
    ///
    var base64Image: UIImage? {
        if let base64Data = self.removeBase64DataPrefixToData(){
            return UIImage.init(data: base64Data)!
        }
        return nil
    }
    
    //移除前缀
    func removeBase64DataPrefixToData() -> Data? {
        var base64String = self

        if base64String.hasPrefix("data:") {
            guard let newBase64String = base64String.components(separatedBy: ",").last else {
                return nil
            }
            base64String = newBase64String
        }
        guard let decodedData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return decodedData
    }
    
    ///获取JavaScript前缀格式
    static func convertBase64PREFIXES(base64String: String) -> String? {
        if base64String.hasPrefix("data:") {
            guard let newBase64String = base64String.components(separatedBy: ",").first else {
                return nil
            }
            return newBase64String
        }
        return nil
    }
    
    /// Base64 前缀到扩展名的映射
        private static let base64Prefixes: [String: String] = [
            // 图片类型
            "data:image/jpeg;base64,": "jpg",
            "data:image/jpg;base64,": "jpg",
            "data:image/png;base64,": "png",
            "data:image/gif;base64,": "gif",
            "data:image/webp;base64,": "webp",
            "data:image/bmp;base64,": "bmp",
            "data:image/svg+xml;base64,": "svg",
            "data:image/tiff;base64,": "tiff",
            "data:image/x-icon;base64,": "ico",
            
            // 音频类型
            "data:audio/mpeg;base64,": "mp3",
            "data:audio/wav;base64,": "wav",
            "data:audio/ogg;base64,": "ogg",
            "data:audio/aac;base64,": "aac",
            "data:audio/flac;base64,": "flac",
            "data:audio/midi;base64,": "mid",
            
            // 视频类型
            "data:video/mp4;base64,": "mp4",
            "data:video/webm;base64,": "webm",
            "data:video/ogg;base64,": "ogv",
            "data:video/x-msvideo;base64,": "avi",
            "data:video/quicktime;base64,": "mov",
            
            // 文档类型
            "data:application/pdf;base64,": "pdf",
            "data:application/msword;base64,": "doc",
            "data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,": "docx",
            "data:application/vnd.ms-excel;base64,": "xls",
            "data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,": "xlsx",
            "data:application/vnd.ms-powerpoint;base64,": "ppt",
            "data:application/vnd.openxmlformats-officedocument.presentationml.presentation;base64,": "pptx",
            "data:text/plain;base64,": "txt",
            "data:text/html;base64,": "html",
            "data:text/css;base64,": "css",
            "data:text/javascript;base64,": "js",
            "data:application/json;base64,": "json",
            "data:application/xml;base64,": "xml",
            
            // 压缩文件
            "data:application/zip;base64,": "zip",
            "data:application/x-rar-compressed;base64,": "rar",
            "data:application/x-7z-compressed;base64,": "7z",
            "data:application/gzip;base64,": "gz",
            "data:application/x-tar;base64,": "tar",
            
            // 字体文件
            "data:font/ttf;base64,": "ttf",
            "data:font/otf;base64,": "otf",
            "data:font/woff;base64,": "woff",
            "data:font/woff2;base64,": "woff2",
        ]
    
    /// 从 MIME 类型获取扩展名
    static func getExtensionFromMimeType(_ mimeType: String) -> String? {
        let prefix = "data:\(mimeType);base64,"
        return base64Prefixes[prefix]
    }
    
    /// 从字符串中提取 MIME 类型
    static func extractMimeType(from base64String: String) -> String? {
        let pattern = "^data:([^;]+);base64,"
        
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: base64String,
                                          range: NSRange(base64String.startIndex..., in: base64String)) else {
            return nil
        }
        
        let range = Range(match.range(at: 1), in: base64String)
        return range.map { String(base64String[$0]) }
    }
}

//MARK: Base64
extension String {
    
    public func encodBase64(using encoding: String.Encoding = .utf8) -> String? {
        if let data = self.data(using: encoding) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    public func decodeBase64(encoding: String.Encoding = .utf8) -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: encoding)
        }
        return nil
    }
    
}
