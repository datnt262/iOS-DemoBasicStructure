//
//  BaseApi.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 02/04/2021.
//

import UIKit
import Foundation
import Alamofire

enum APIError: Error {
    case noInternet
    case tokenExpired(_ errorCode:Int?)
    case requireToken(_ errorCode:Int?)
    case noResponse(_ errorCode:Int?)
    case wrongJson
    case notFound(_ message: String?,_ errorCode:Int?)
    case otherError(_ message: String?,_ errorCode:Int?)
}

typealias APICompletionHandler<T: Codable> = (_ result: Swift.Result<T, APIError>) -> Void

/// Class for base API
class BaseApi: NSObject {
    var request: DataRequest?
    
    /// URL domain for request
    /// - Returns: domain string
    public func baseUrl() -> String {
        return Enviroment.getMainUrl()
    }
    
    /// URL path for request
    /// - Returns: URL string
    public func path() -> String {
        return ""
    }
    
    /// Method of request
    /// - Returns: HTTPMethod
    public func method() -> HTTPMethod {
        return .get
    }
    
    /// Header of request
    /// - Returns: HTTPHeaders?
    public func headers() -> HTTPHeaders? {
        return [.contentType("application/json")]
    }
    
    /// Parameter of request
    /// - Returns: dictionary Parameter
    public func parameters() -> [String: Any]? {
        return nil
    }
    
    /// Image to upload of request
    /// - Returns: image that want to upload
    public func image() -> UIImage {
        return UIImage()
    }
    
    public func encoding() -> ParameterEncoding {
        return JSONEncoding.default
    }
    
    /// Request timeout
    /// - Returns: TimeInterval
    public func timeout() -> TimeInterval {
        return 60
    }
    
    /// Call request to server
    /// - Parameters:
    ///   - queue: queue that will request
    ///   - responseType: response model type
    ///   - completion: result of request
    public func request<T: Decodable>(_ queue: DispatchQueue = .main,
                                      modelType: T.Type,
                                      _ completion: @escaping APICompletionHandler<T>) {
        if !NetworkManager.shared.isConnected {
            completion(.failure(.noInternet))
            return
        }
        
        let url = self.baseUrl() + self.path()
        let method = self.method()
        let headers = self.headers()
        let parameters = self.parameters()
        let encoding = self.encoding()
        
        self.request = AF.request(url,
                                  method: method,
                                  parameters: parameters,
                                  encoding: encoding,
                                  headers: headers).validate(statusCode: 200..<300)
        self.handleResponse(modelType: modelType, completion)
    }
    
    /// Get request upload image to server by multipart
    /// - Parameters:
    ///   - queue: queue to request
    ///   - completion: result of upload progress
    /// - Returns: Request
    public func upload<T: Decodable>(_ queue: DispatchQueue = DispatchQueue.main,
                                     withName: String = "file",
                                     fileName: String,
                                     mimeType: String = "image/jpg",
                                     modelType: T.Type,
                                     completion: @escaping APICompletionHandler<T>) {
        let url = self.baseUrl() + self.path()
        let method = self.method()
        let headers = self.headers()
        let parameters = self.parameters()
        let imageData = image().jpegData(compressionQuality: 1.0)!
        
        self.request = AF.upload(multipartFormData: { multiPart in
            if let params = parameters {
                for param in params {
                    if let paramData = "\(param.value)".data(using: String.Encoding.utf8) {
                        multiPart.append(paramData, withName: param.key)
                    }
                }
            }
            multiPart.append(imageData, withName: withName, fileName: fileName, mimeType: mimeType)
        }, to: url, method: method, headers: headers)
        .uploadProgress(queue: .main, closure: { progress in
            Logger.debug(message: "Upload Progress: \(progress.fractionCompleted)")
        }).validate(statusCode: 200..<300)
        self.handleResponse(modelType: modelType, completion)
    }
    
    public func cancel() {
        self.request?.cancel()
    }
    
    /// Handle response data from request
    /// - Parameters:
    ///   - modelType: type of decodable model
    ///   - completion: completion
    private func handleResponse<T: Decodable>(modelType: T.Type, _ completion: @escaping APICompletionHandler<T>) {
        self.request?.responseData { responseData in
            switch responseData.result {
            case .success(let data):
                let statusCode = responseData.response?.statusCode ?? 200
                let responseString = self.responseString(statusCode, error: responseData.error, data: data)
                let mesLog = self.requestString() + responseString
                Logger.logs(message: mesLog)
                
                JSONDecoder.decode(modelType, from: data) { error, result in
                    if let result = result {
                        completion(.success(result))
                    } else {
                        Logger.logs(type: .error, message: "Wrong Json: \(String(describing: error))")
                        completion(.failure(.wrongJson))
                    }
                }
            case .failure(let error):
                let statusCode = responseData.response?.statusCode ?? 404
                let responseString = self.responseString(statusCode, error: error, data: nil)
                let mesLog = self.requestString() + responseString
                Logger.logs(message: mesLog)
                
                completion(.failure(.notFound(error.localizedDescription, error.responseCode)))
            }
        }
    }
}

extension JSONDecoder {
    static func decode<T: Decodable>(_ type: T.Type, from data: Data?, completion: @escaping(_ error: String?, _ result: T?) -> Void) {
        
        guard let data = data else {
            completion("The data coundn't be read because it is missing", nil)
            return
        }
        
        let jsonDecoder = JSONDecoder()
        do {
            let result = try jsonDecoder.decode(type, from: data)
            completion(nil, result)
        } catch(let error) {
            Logger.logs(type: .error, message: "error \(error)")
            completion(error.localizedDescription, nil)
        }
    }
}

//Helper
extension BaseApi {
    private func requestString() -> String {
        var result = "\n======REQUEST======"
        result = String.init(format: "%@\n%@", result, "URL: \(self.baseUrl())\(self.path())")
        result = String.init(format: "%@\n%@", result, "METHOD: \(self.method())")
        if let headers = self.headers() {
            result = String.init(format: "%@\n%@", result, "HEADER: \(headers)")
        }
        if let parameters = self.parameters() {
            result = String.init(format: "%@\n%@", result, "PARAMETERS: \(parameters)")
        }
        return result + "\n==================="
    }
    
    private func responseString(_ code: Int, error: AFError?, data: Any?) -> String {
        var result = "\n======RESPONSE======"
        result = String.init(format: "%@\n%@", result, "HTTP CODE: \(code)")
        var json: [String: Any]?
        if let data = data {
            do {
                json = try JSONSerialization.jsonObject(with: (data as? Data)!, options: []) as? [String : Any]
            } catch {
                print(error)
            }
            result = String.init(format: "%@\n%@", result, "DATA: \(json ?? [:])")
        }
        if let error = error {
            result = String.init(format: "%@\n%@", result, "ERROR: \(error)")
        }
        return result + "\n==================="
    }
    
    private func getErrorCode(_ error: Error) -> Int {
        var code: Int
        if let error = error.asAFError {
            code = error._code
        } else if let error = error as? URLError {
            code = error.code.rawValue
        } else {
            code = URLError.unknown.rawValue
        }
        return code
    }
}
