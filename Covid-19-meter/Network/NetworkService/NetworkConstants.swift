//
//  NetworkConstants.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 25/04/2022.
//

import Foundation

// MARK: - Network Typealias

typealias HTTPBody = Data?
typealias Params = [String: Any]
typealias Headers = [String: String]
typealias QueryItems = [String: String]
typealias PathVariables = [String: String]
typealias MultipartFormParams = [String: String]

// MARK: - HTTPMethod

enum HTTPMethod: String {
    case get = "GET"
}

// MARK: - MultipartFormItem

struct MultipartFormItem {
    let filename = UUID().uuidString
    let parameter: String
    let data: Data
    let `extension`: String
    
    var fullname: String {
        filename + "." + `extension`
    }
}
