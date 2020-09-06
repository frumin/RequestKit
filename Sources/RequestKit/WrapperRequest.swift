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
        guard let myUrl = request?.url,
            let myComponents = URLComponents(url: myUrl, resolvingAgainstBaseURL: false),
            let otherUrl = otherRequest.request?.url,
            let otherComponents = URLComponents(url: otherUrl, resolvingAgainstBaseURL: false) else { return self }
        
        let combinedComponents = myComponents.combined(with: otherComponents)
        
        guard let url = combinedComponents.url else { return self }
        
        var combinedRequest = URLRequest(url: url)
        if let myHeaders = request?.allHTTPHeaderFields {
            let combinedHeaders = myHeaders.merging((otherRequest.request?.allHTTPHeaderFields  ?? [:])) { (_, new) in
                new
            }
            combinedRequest.allHTTPHeaderFields = combinedHeaders
        } else {
            combinedRequest.allHTTPHeaderFields = otherRequest.request?.allHTTPHeaderFields
        }
        
        return WrapperRequest(request: combinedRequest)
    }
}
