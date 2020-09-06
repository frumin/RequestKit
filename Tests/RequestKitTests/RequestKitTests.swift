import XCTest
@testable import RequestKit

struct SampleRequestBuilder {
	
	@RequestBuilder func makeSampleRequest() -> RequestComponent {
        Scheme("x-sample-app")
        Host("example.com")
        Port(8080)
        
		Path("/api/v1")
		Path("/search")
		
        QueryItem("q", value: "test")
        QueryItem("api_version", value: "1.0")
        
        AcceptHeader.applicationJson
		
		Header("Authentication", "Bearer j4q32489w8e9fw")
		Header("x-client-id", "EDDD436F-7D2F-4B4B-80BD-A9403EB06BD5")
        
	}
	
}

final class RequestKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let component = SampleRequestBuilder().makeSampleRequest()
        guard let request = component.request else {
            XCTAssert(false)
            return
        }
        
        XCTAssertEqual(request.allHTTPHeaderFields?["Accept"], "application/json")
        XCTAssertEqual(request.allHTTPHeaderFields?["Authentication"], "Bearer j4q32489w8e9fw")
        XCTAssertEqual(request.allHTTPHeaderFields?["x-client-id"], "EDDD436F-7D2F-4B4B-80BD-A9403EB06BD5")
        
        XCTAssertEqual(request.url?.absoluteString, "x-sample-app://example.com:8080/api/v1/search?q=test&api_version=1.0")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
