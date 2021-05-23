//
//  Optional+Additions.swift
//  RequestKit
//
//  Created by Tom Zaworowski on 9/5/20.
//

import Foundation

extension Optional {
    mutating func setValueForNil(_ value: Wrapped?) {
        if self == nil {
            guard value != nil else { return }
            self = value
        }
    }
}

extension Optional where Wrapped: RangeReplaceableCollection {
    mutating func add(_ collection: Wrapped?) {
        if self == nil {
            guard collection != nil else { return }
            self = collection
        } else if let collection = collection {
            self! += collection
        }
    }
}
