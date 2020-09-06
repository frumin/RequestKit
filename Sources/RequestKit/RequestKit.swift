//
//  RequestKit.swift
//  RequestKit
//
//  Created by Tom Zaworowski on 9/5/20.
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

@_functionBuilder public struct RequestBuilder {
    
	public static func buildBlock(_ partialResults: RequestComponent...) -> RequestComponent {
		partialResults.reduce(partialResults.first!) { first, next in
			return first.combined(with: next)
		}
	}
    
    public static func buildIf(_ value: RequestComponent?) -> RequestComponent {
        value ?? WrapperRequest.init(request: nil)
    }
    
    public static func buildEither(first: RequestComponent) -> RequestComponent {
        first
    }

    public static func buildEither(second: RequestComponent) -> RequestComponent {
        second
    }
}
