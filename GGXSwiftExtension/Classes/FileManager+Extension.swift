//
//  File.swift
//  DaDaBaby
//
//  Created by FreakyYang on 2018/10/23.
//  Copyright © 2018年 jerry.li. All rights reserved.
//

import Foundation

public extension FileManager {

    /**
     * 计算单个文件的大小
     */
    static func fileSize(path: String) -> Double {
        let manager = FileManager.default
        var fileSize: Double = 0
        do {
            let attr = try manager.attributesOfItem(atPath: path)
            fileSize = Double(attr[FileAttributeKey.size] as? UInt64 ?? 0)
            let dict = attr as NSDictionary
            fileSize = Double(dict.fileSize())
        } catch {
            dump(error)
        }
        return fileSize/1024/1024
    }

    /**
     * 遍历所有子目录， 并计算文件大小
     */
    static func folderSizeAtPath(folderPath: String) -> Double {
        let manage = FileManager.default
        if !manage.fileExists(atPath: folderPath) {
            return 0
        }
        let childFilePath = manage.subpaths(atPath: folderPath)
        var fileSize: Double = 0
        guard let nnChildFilePath = childFilePath else { return 0 }
        for path in nnChildFilePath {
            let fileAbsoluePath = folderPath+"/"+path
            fileSize += self.fileSize(path: fileAbsoluePath)
        }
        return fileSize
    }
}
