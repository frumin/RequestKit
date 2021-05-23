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

public protocol FormComponent {
    var data: Data? { get }
    
    func combined(with: FormComponent) -> FormComponent
}

extension FormComponent {
    public func combined(with component: FormComponent) -> FormComponent {
        return WrapperForm(data: component.data)
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

@resultBuilder public struct FormBuilder {
    public static func buildBlock(_ partialResults: FormComponent...) -> FormComponent {
        partialResults.reduce(WrapperForm(data: nil)) { first, next in
            return first.combined(with: next)
        }
    }
    
    public static func buildIf(_ value: FormComponent?) -> FormComponent {
        value ?? WrapperForm(data: nil)
    }
    
    public static func buildEither(first: FormComponent) -> FormComponent {
        first
    }

    public static func buildEither(second: FormComponent) -> FormComponent {
        second
    }
}
