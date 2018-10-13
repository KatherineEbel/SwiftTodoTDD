//
//  ToDoItemTests.swift
//  TodoTests
//
//  Created by Katherine Ebel on 10/13/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import XCTest
@testable import Todo
class ToDoItemTests: XCTestCase {

    override func setUp() {

    }

    override func tearDown() {
    }
  
  func test_Init_WhenGivenTitle_SetsTitle() {
    let item = TodoItem(title: "Foo")
    XCTAssertEqual(item.title, "Foo", "should set title")
  }

  func test_Init_WhenGivenDescriptionSetsDescription() {
    let item = TodoItem(title: "Foo",
                 itemDescription: "Bar")
    XCTAssertEqual(item.itemDescription, "Bar")
  }
}
