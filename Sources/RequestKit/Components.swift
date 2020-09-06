//
//  Components.swift
//  RequestKit
//
//  Created by Tom Zaworowski on 9/5/20.
//

import Foundation

public enum Method: String, RequestComponent {
    case get = "GET"
    case post = "POST"
    
    public var request: URLRequest? {
        let components = URLComponents()
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url).applyingDefaultValues()
        request.httpMethod = self.rawValue
        return request
    }
}

public struct Header: RequestComponent {
    let key: String
    let value: String
    
    public init(_ key: String, _ value: String) {
        self.key = key
        self.value = value
    }
    
    public var request: URLRequest? {
        let components = URLComponents()
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url).applyingDefaultValues()
        request.setValue(value, forHTTPHeaderField: key)
        return request
    }
}

public struct AcceptHeader: RequestComponent {
    
    public static let applicationJson: AcceptHeader = {
       return AcceptHeader("application/json")
    }()
    
    public let request: URLRequest?
    
    public init(_ value: String) {
        request = Header("Accept", value).request
    }
}

public struct Host: RequestComponent {
    
    let name: String
    
    public init(_ name: String) {
        self.name = name
    }
    
    public var request: URLRequest? {
        let components = URLComponents(host: name)
        guard let url = components.url else { return nil }
        return URLRequest(url: url).applyingDefaultValues()
    }
}

public struct Port: RequestComponent {
    let port: Int
    
    public init(_ port: Int) {
        self.port = port
    }
    
    public var request: URLRequest? {
        let components = URLComponents(port: port)
        guard let url = components.url else { return nil }
        return URLRequest(url: url).applyingDefaultValues()
    }
}

public struct Scheme: RequestComponent {
    let scheme: String
    
    public init(_ scheme: String) {
        self.scheme = scheme
    }
    
    public var request: URLRequest? {
        let components = URLComponents(scheme: scheme)
        guard let url = components.url else { return nil }
        return URLRequest(url: url).applyingDefaultValues()
    }
}

public struct Path: RequestComponent {
    
    let path: String
    
    public init(_ path: String) {
        self.path = path
    }
    
    public var request: URLRequest? {
        let components = URLComponents(path: path)
        guard let url = components.url else { return nil }
        return URLRequest(url: url).applyingDefaultValues()
    }
}

public struct QueryItem: RequestComponent {
    let key: String
    let value: String
    
    public init(_ name: String, value: String) {
        self.key = name
        self.value = value
    }
    
    public var request: URLRequest? {
        let queryItem = URLQueryItem(name: key, value: value)
        let components = URLComponents(queryItems: [queryItem])
        guard let url = components.url else { return nil }
        return URLRequest(url: url).applyingDefaultValues()
    }
}

public struct Form: RequestComponent {
    
    public let request: URLRequest?
    
    public init(@FormBuilder builder: () -> FormComponent) {
        let components = URLComponents()
        guard let url = components.url else {
            request = nil
            return
        }
        var formRequest = URLRequest(url: url).applyingDefaultValues()
        formRequest.httpBody = builder().data
        request = formRequest
    }
    
}

public struct FormData: FormComponent {
    public let data: Data?
    
    public init(_ data: Data) {
        self.data = data
    }
}

public struct FormText: FormComponent {
    public let data: Data?
    
    public init(_ string: String) {
        self.data = string.data(using: .utf8)
    }
}
