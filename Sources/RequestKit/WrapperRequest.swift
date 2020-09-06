//
//  WrapperRequest.swift
//  RequestKit
//
//  Created by Tom Zaworowski on 9/5/20.
//

import Foundation

struct WrapperRequest: RequestComponent {
    let request: URLRequest?
    
    func combined(with otherRequest: RequestComponent) -> RequestComponent {
        let combinedComponents: URLComponents
        if let myUrl = request?.url,
            let myComponents = URLComponents(url: myUrl, resolvingAgainstBaseURL: false),
            let otherUrl = otherRequest.request?.url,
            let otherComponents = URLComponents(url: otherUrl, resolvingAgainstBaseURL: false) {
            combinedComponents = myComponents.combined(with: otherComponents)
        } else if let otherUrl = otherRequest.request?.url,
            let otherComponents = URLComponents(url: otherUrl, resolvingAgainstBaseURL: false) {
            combinedComponents = otherComponents
        } else {
            return self
        }
        
        guard let url = combinedComponents.url else { return self }
        
        var combinedRequest = URLRequest(url: url).applyingDefaultValues()
        if let myHeaders = request?.allHTTPHeaderFields {
            let combinedHeaders = myHeaders.merging((otherRequest.request?.allHTTPHeaderFields  ?? [:])) { (_, new) in
                new
            }
            combinedRequest.allHTTPHeaderFields = combinedHeaders
        } else {
            combinedRequest.allHTTPHeaderFields = otherRequest.request?.allHTTPHeaderFields
        }
        
        if let otherMethod = otherRequest.request?.httpMethod, otherMethod != URLRequest.Constants.nullHttpMethodValue {
            combinedRequest.httpMethod = otherMethod
        } else {
            combinedRequest.httpMethod = request?.httpMethod ?? URLRequest.Constants.nullHttpMethodValue
        }
        
        if let otherBody = otherRequest.request?.httpBody {
            combinedRequest.httpBody = otherBody
        } else {
            combinedRequest.httpBody = request?.httpBody
        }
        
        return WrapperRequest(request: combinedRequest)
    }
}
