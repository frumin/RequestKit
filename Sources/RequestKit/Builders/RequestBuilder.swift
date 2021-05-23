//
//  RequestBuilder.swift
//  RequestKit
//
//  Created by Tom Zaworowski on 5/22/21.
//

import Foundation

public protocol RequestComponent {
    var request: URLRequest? { get }
    
    func combined(with: RequestComponent) -> RequestComponent
}

extension RequestComponent {
    
    public func combined(with request: RequestComponent) -> RequestComponent {
        WrapperRequest(request: request.request)
    }
}

@resultBuilder public struct RequestBuilder {
    
    public static func buildBlock(_ partialResults: RequestComponent...) -> RequestComponent {
        partialResults.reduce(WrapperRequest(request: nil)) { first, next in
            return first.combined(with: next)
        }
    }
    
    public static func buildIf(_ value: RequestComponent?) -> RequestComponent {
        value ?? WrapperRequest(request: nil)
    }
    
    public static func buildEither(first: RequestComponent) -> RequestComponent {
        first
    }

    public static func buildEither(second: RequestComponent) -> RequestComponent {
        second
    }
}
