//
//  NetWorkMonitor.swift
//  ProyectoTest
//
//  Created by Patricio Tovar on 6/10/22.
//

import Foundation
import Network

class NetWorkMonitor {
    static let shared = NetWorkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    
    private init(){
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            
        }
    }
    
    public func stopMonitoring(){
        monitor.cancel()
    }
    
    
}
