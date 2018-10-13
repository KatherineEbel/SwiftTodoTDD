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
  func test_Init_WhenGivenTitle_SetsTitle() {
    let item = TodoItem(title: "Foo")
    XCTAssertEqual(item.title, "Foo", "should set title")
  }

  func test_Init_WhenGivenDescriptionSetsDescription() {
    let item = TodoItem(title: "Foo",
                 itemDescription: "Bar")
    XCTAssertEqual(item.itemDescription, "Bar")
  }
  
  func test_Init_SetsTimestamp() {
    let item = TodoItem(title: "", timestamp: 0.0)
    XCTAssertEqual(item.timestamp, 0.0, "should set timestamp")
  }
  
  func test_Init_WhenGivenLocation_SetsLocation() {
    let location = Location(name: "Foo")
    let item = TodoItem(title: "", location: location)
    XCTAssertEqual(item.location?.name, location.name, "should set location")
  }

  func test_EqualItems_AreEqual() {
    let first = TodoItem(title: "Foo")
    let second = TodoItem(title: "Foo")
    XCTAssertEqual(first, second)
  }

  func test_Items_WhenLocationDiffers_AreNotEqual() {
    let first = TodoItem(title: "", location: Location(name: "Foo"))
    let second = TodoItem(title: "", location: Location(name: "Bar"))
    XCTAssertNotEqual(first, second)
  }
}
