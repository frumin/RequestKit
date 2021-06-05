# RequestKit

RequestKit is a framework for composing `URLRequest` objects using Swift's result builder feature

## Features

* Lightweight DSL for composing `NSURLRequest` objects
* Support for forms
* Extentedable using `RequestComponent` protocol

## Requirements

RequestKit uses Swift's result builder feature availble in Swift 5.4 and Xcode 12.5

## Installation

Using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/frumin/RequestKit.git", .branch("master"))
]
```
## Usage

```swift
@RequestBuilder func makeSampleRequest() -> RequestComponent {
  Method.post
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
    if condition {
      FormText("testing")
      FormText("123")
    } else {
      FormData(Data(repeating: 0x41, count: 1))
    }
  }
}
```
