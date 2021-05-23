//
//  WrapperForm.swift
//  RequestKit
//
//  Created by Tom Zaworowski on 9/6/20.
//

import Foundation

struct WrapperForm: FormComponent {
    let data: Data?
    
    func combined(with otherComponent: FormComponent) -> FormComponent {
        guard let data = data else {
            return WrapperForm(data: otherComponent.data)
        }
        if let otherData = otherComponent.data {
            return WrapperForm(data: data + otherData)
        }
        return self
    }
}
