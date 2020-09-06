//
//  URLComponents+Additions.swift
//  RequestKit
//
//  Created by Tom Zaworowski on 9/5/20.
//

import Foundation

extension URLComponents {

    func combined(with components: URLComponents) -> URLComponents {
        var newComponents = self
        newComponents.host.setValueForNil(components.host)
        newComponents.scheme.setValueForNil(components.scheme ?? "https")
        newComponents.port.setValueForNil(components.port)
        newComponents.queryItems.add(components.queryItems)
        newComponents.path += components.path
        
        return newComponents
    }
}

extension URLComponents {
    init(host: String) {
        self.init()
        self.host = host
    }
    
    init(port: Int) {
        self.init()
        self.port = port
    }
    
    init(scheme: String) {
        self.init()
        self.scheme = scheme
    }
    
    init(path: String) {
        self.init()
        self.path = path
    }
    
    init(queryItems: [URLQueryItem]) {
        self.init()
        self.queryItems = queryItems
    }
}
