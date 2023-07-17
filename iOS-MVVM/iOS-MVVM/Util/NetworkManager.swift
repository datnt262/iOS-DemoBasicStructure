//
//  NetworkManager.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import Network

typealias NetworkConnected = Bool

protocol NetworkManagerDelegate: AnyObject {
    func connected()
    func disConnected()
}

/// Class for network manager
class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    fileprivate let monitor = NWPathMonitor()
    var isConnected = true
    var connectStatus: ((NetworkConnected) -> ())?
    
    /// Start checking network connection
    /// Will trigger connectStatus closure if status changed
    func startChecking() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                if (self?.isConnected) == false {
                    self?.isConnected = true
                    self?.connectStatus?(true)
                }
            } else {
                if (self?.isConnected) == true {
                    self?.isConnected = false
                    self?.connectStatus?(false)
                }
            }
            
            print(path.isExpensive)
        }
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
}
