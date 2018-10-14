//
//  APIClientTests.swift
//  TodoTests
//
//  Created by Katherine Ebel on 10/14/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import XCTest
@testable import Todo
class APIClientTests: XCTestCase {
  var sut: APIClient!
  var mockURLSession: MockURLSession!
  
  override func setUp() {
    sut = APIClient()
    mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
    sut.session = mockURLSession
  }
  func test_Login_UsesExpectedHost() {
    let completion = { (token: Token?, error: Error?) in }
    sut.loginUser(withName: "dasdom", password: "1234", completion: completion)
    
    XCTAssertEqual(mockURLSession.urlComponents?.host, "awesometodos.com")
  }
  
  func test_Login_UsesExpectedPath() {
    let completion = { (token: Token?, error: Error?) in }
    sut.loginUser(withName: "dasdom", password: "1234", completion: completion)
    XCTAssertEqual(mockURLSession.urlComponents?.path, "/login")
  }
  
  func test_Login_UsesExpectedQuery() {
    let completion = { (token: Token?, error: Error?) in }
    sut.loginUser(withName: "dasdöm", password: "%&34", completion: completion)
    if let components = mockURLSession.urlComponents, let queryItems = components.queryItems {
      XCTAssertEqual(queryItems[0].value, "dasdöm")
        XCTAssertEqual(queryItems[1].value, "%&34")
    } else {
      XCTFail()
    }
  }
  
  func test_Login_WhenSuccessful_CreatesToken() {
    let jsonData = "{\"token\": \"123456789\"}".data(using: .utf8)
    mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
    sut.session = mockURLSession
    
    let tokenExpectation = expectation(description: "Token")
    var caughtToken: Token? = nil
    sut.loginUser(withName: "Foo", password: "Bar") {
      token, _ in
      caughtToken = token
      tokenExpectation.fulfill()
    }
    waitForExpectations(timeout: 1) { _ in
      XCTAssertEqual(caughtToken?.id, "123456789")
    }
  }
  
  func test_Login_WhenJSONIsInvalid_ReturnsError() {
    mockURLSession = MockURLSession(data: Data(), urlResponse: nil, error: nil)
    sut.session = mockURLSession
    
    let errorExpectation = expectation(description: "Error")
    var caughtError: Error? = nil
    sut.loginUser(withName: "Foo", password: "Bar") {
      (token, error) in
      caughtError = error
      errorExpectation.fulfill()
    }
    waitForExpectations(timeout: 1) {
      (error) in
       XCTAssertNotNil(caughtError)
    }
  }
  
  func test_Login_WhenDataIsNill_ReturnsError() {
    mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
    sut.session = mockURLSession
    
    let errorExpectation = expectation(description: "Error")
    var caughtError: Error? = nil
    sut.loginUser(withName: "Foo", password: "Bar") {
      (token, error) in
      caughtError = error
      errorExpectation.fulfill()
    }
    waitForExpectations(timeout: 1) { (error) in
      XCTAssertNotNil(caughtError)
    }
  }
  
  func test_Login_WhenResponseHasError_ReturnsError() {
    let error = NSError(domain: "SomeError", code: 1224, userInfo: nil)
    let jsonData = "{\"token\": \"1234567890\"}".data(using: .utf8)
    mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: error)
    sut.session = mockURLSession
    let errorExpectation = expectation(description: "Error")
    var caughtError: Error? = nil
    sut.loginUser(withName: "Foo", password: "Bar") {
      (token, error) in
      caughtError = error
      errorExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 1) { (error) in
      XCTAssertNotNil(caughtError)
    }
  }
}

extension APIClientTests {
  class MockURLSession: SessionProtocol {
    
    var url: URL?
    private let dataTask: MockTask
    var urlComponents: URLComponents? {
      guard let url = url else { return nil }
      return URLComponents(url: url, resolvingAgainstBaseURL: true)
    }
    
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
      dataTask = MockTask(data: data, urlResponse: urlResponse, error: error)
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
      self.url = url
      print(url)
      dataTask.completionHandler = completionHandler
      return dataTask
    }
  }
  
  class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?
    private let responseError: Error?
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var completionHandler: CompletionHandler?
    
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
      self.data = data
      self.urlResponse = urlResponse
      self.responseError = error
    }
    
    override func resume() {
      DispatchQueue.main.async {
        self.completionHandler?(self.data, self.urlResponse, self.responseError)
      }
    }
  }
}
