//
//  FormBuilder.swift
//  RequestKit
//
//  Created by Tom Zaworowski on 5/22/21.
//

import Foundation

public protocol FormComponent {
    var data: Data? { get }
    
    func combined(with: FormComponent) -> FormComponent
}

extension FormComponent {
    public func combined(with component: FormComponent) -> FormComponent {
        return WrapperForm(data: component.data)
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
