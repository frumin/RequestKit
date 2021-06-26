import XCTest
@testable import RequestKit

struct SampleRequestBuilder {
    
    typealias RequestBuilderBlock = () -> RequestComponent
    
    let condition: Bool
	
    @RequestBuilder func makeSampleRequest(@RequestBuilder _ additionalComponents: RequestBuilderBlock) -> RequestComponent {
        Scheme("x-sample-app")
        Host("example.com")
        Port(8080)
        
		Path("/api/v1")
		Path("/search")
		
        QueryItem("q", value: "test")
        QueryItem("api_version", value: "1.0")
        
        if condition {
            QueryItem("condition", value: "true")
        } else {
            QueryItem("condition", value: "false")
        }
        
        AcceptHeader.applicationJson
		
		Header("Authentication", "Bearer j4q32489w8e9fw")
		Header("x-client-id", "EDDD436F-7D2F-4B4B-80BD-A9403EB06BD5")
        
        Form {
            FormText("testing")
            FormText("123")
            FormData(Data(repeating: 0x41, count: 1))
        }
        
        additionalComponents()
	}
	
}

final class RequestKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let component = SampleRequestBuilder(condition: true).makeSampleRequest() { }
        guard let request = component.request else {
            XCTAssert(false)
            return
        }
        
        XCTAssertEqual(request.allHTTPHeaderFields?["Accept"], "application/json")
        XCTAssertEqual(request.allHTTPHeaderFields?["Authentication"], "Bearer j4q32489w8e9fw")
        XCTAssertEqual(request.allHTTPHeaderFields?["x-client-id"], "EDDD436F-7D2F-4B4B-80BD-A9403EB06BD5")
        
        XCTAssertEqual(request.url?.absoluteString, "x-sample-app://example.com:8080/api/v1/search?q=test&api_version=1.0&condition=true")
        
        XCTAssertEqual(request.httpMethod, "GET")
        
        XCTAssertEqual(String(data: request.httpBody!, encoding: .utf8), "testing123A")
    }
    
    func testMethodChange() {
        let component = SampleRequestBuilder(condition: true).makeSampleRequest() {
            Method.post
        }
        guard let request = component.request else {
            XCTAssert(false)
            return
        }
        
        XCTAssertEqual(request.httpMethod, "POST")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
