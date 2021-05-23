//
//  URLRequest+Additions.swift
//  RequestKit
//
//  Created by Tom Zaworowski on 9/6/20.
//

import Foundation

extension URLRequest {
    
    struct Constants {
        static let nullHttpMethodValue = ""
    }
    
    func applyingDefaultValues() -> URLRequest {
        var request = self
        request.httpMethod = Constants.nullHttpMethodValue
        request.allHTTPHeaderFields = nil
        request.httpBody = nil
        return request
    }
}
