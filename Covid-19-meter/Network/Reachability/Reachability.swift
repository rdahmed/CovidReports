//
//  Reachability.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Network

class Reachability {
    
    static let shared = Reachability()
    private init() {
        monitor.pathUpdateHandler = { path in
            self.isReachable = path.status == .satisfied
            self.log(path)
        }
    }
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    var isReachable: Bool = false
    
    func start() {
        monitor.start(queue: queue)
    }
    
    func stop() {
        monitor.cancel()
    }
    
    private func log(_ path: NWPath) {
        var logs = "🌍"
        
        logs += " "
        if path.status == .satisfied {
            logs += "REACHABLE"
        } else {
            logs += "NOT REACHABLE"
        }
        
        logs += " --- "
        if path.isExpensive {
            logs += "IS EXPENSIVE (Cellular)"
        } else {
            logs += "NOT EXPENSIVE (Wifi)"
        }
        
        print(logs)
    }
    
}
