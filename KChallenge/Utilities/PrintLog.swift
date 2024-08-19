//
//  PrintLog.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

class PrintLog {
    class func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line ) {
        let className = (file.components(separatedBy: "/").last)?.components(separatedBy: ".").first
        debugPrint("[\(className!) \(function)] line: \(line) - \(message)")
    }
}
