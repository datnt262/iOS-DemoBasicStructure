//
//  Logger.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import Foundation

/// Custom log event
enum LogEvents: String {
    case debug = "🟢[DEBUG]"
    case info  = "🔵[INFO]"
    case event = "🟡[EVENT]"
    case warn  = "🟠[WARNING]"
    case error = "🔴[ERROR]"
}

/// Class for logger, to print log
open class Logger: NSObject {
    
    /// File name, where call this method
    /// - Parameter filePath: file path
    /// - Returns: file name
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!.replace(string: ".swift", replacement: "")
    }
    
    /// Get current date time
    /// - Returns: date time in string
    private class func getDateTime() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: Date())
    }
    
    /// Print log to console
    /// - Parameters:
    ///   - event: custom log event, default is .debug
    ///   - message: message of log
    ///   - fileName: name of file that call this method
    ///   - funcName: name of function that call this method
    ///   - line: line of code
    static func logs(type: LogEvents = LogEvents.debug, message: Any, fileName: String = #file, funcName: String = #function, line: Int = #line) {
        print("\(self.getDateTime()) \(type.rawValue) [\(sourceFileName(filePath: fileName))] [\(line)] \(funcName): \(message)")
    }
    
    /// Print event log to console
    /// - Parameters:
    ///   - message: message of log
    ///   - fileName: name of file that call this method
    ///   - funcName: name of function that call this method
    ///   - line: line of code
    static func event(message: Any, fileName: String = #file, funcName: String = #function, line: Int = #line) {
        print("\(self.getDateTime()) \(LogEvents.event.rawValue) [\(sourceFileName(filePath: fileName))] [\(line)] \(funcName): \(message)")
    }
    
    /// Print debug log to console
    /// - Parameters:
    ///   - message: message of log
    ///   - fileName: name of file that call this method
    ///   - funcName: name of function that call this method
    ///   - line: line of code
    static func debug(message: Any, fileName: String = #file, funcName: String = #function, line: Int = #line) {
        print("\(self.getDateTime()) \(LogEvents.debug.rawValue) [\(sourceFileName(filePath: fileName))] [\(line)] \(funcName): \(message)")
    }
    
    /// Print error log to console
    /// - Parameters:
    ///   - message: message of log
    ///   - fileName: name of file that call this method
    ///   - funcName: name of function that call this method
    ///   - line: line of code
    static func error(message: Any, fileName: String = #file, funcName: String = #function, line: Int = #line) {
        print("\(self.getDateTime()) \(LogEvents.error.rawValue) [\(sourceFileName(filePath: fileName))] [\(line)] \(funcName): \(message)")
    }
}
