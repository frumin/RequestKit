//
//  Components.swift
//  RequestKit
//
//  Created by Tom Zaworowski on 9/5/20.
//

import Foundation

public struct Header: RequestComponent {
    let key: String
    let value: String
    
    init(_ key: String, _ value: String) {
        self.key = key
        self.value = value
    }
    
    public var request: URLRequest? {
        let components = URLComponents()
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue(value, forHTTPHeaderField: key)
        return request
    }
}

public struct AcceptHeader: RequestComponent {
    
    public static let applicationJson: AcceptHeader = {
       return AcceptHeader("application/json")
    }()
    
    public let request: URLRequest?
    
    init(_ value: String) {
        request = Header("Accept", value).request
    }
}

public struct Host: RequestComponent {
    
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    public var request: URLRequest? {
        let components = URLComponents(host: name)
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
}

public struct Port: RequestComponent {
    let port: Int
    
    init(_ port: Int) {
        self.port = port
    }
    
    public var request: URLRequest? {
        let components = URLComponents(port: port)
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
}

public struct Scheme: RequestComponent {
    let scheme: String
    
    init(_ scheme: String) {
        self.scheme = scheme
    }
    
    public var request: URLRequest? {
        let components = URLComponents(scheme: scheme)
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
}

public struct Path: RequestComponent {
    
    let path: String
    
    init(_ path: String) {
        self.path = path
    }
    
    public var request: URLRequest? {
        let components = URLComponents(path: path)
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
}

public struct QueryItem: RequestComponent {
    let key: String
    let value: String
    
    init(_ name: String, value: String) {
        self.key = name
        self.value = value
    }
    
    public var request: URLRequest? {
        let queryItem = URLQueryItem(name: key, value: value)
        let components = URLComponents(queryItems: [queryItem])
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
}
