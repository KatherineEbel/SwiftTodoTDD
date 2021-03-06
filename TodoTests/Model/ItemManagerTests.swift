//
// Created by Katherine Ebel on 10/13/18.
// Copyright (c) 2018 Katherine Ebel. All rights reserved.
//

import XCTest
import UIKit
@testable import Todo

class ItemManagerTests: XCTestCase {
  var sut: ItemManager!

  override func setUp() {
    super.setUp()
    sut = ItemManager()
  }

  override func tearDown() {
    sut.removeAll()
    sut = nil
    super.tearDown()
  }

  func test_TodDoCount_Initially_IsZero() {
    XCTAssertEqual(sut.toDoCount, 0)
  }

  func test_DoneCount_InitiallyZero() {
    XCTAssertEqual(sut.doneCount, 0)
  }

  func test_AddItem_IncreasesToDoCountToOne() {
    sut.add(TodoItem(title: ""))
    XCTAssertEqual(sut.toDoCount, 1)
  }

  func test_ItemAt_ReturnsAddedItem() {
    let item = TodoItem(title: "Foo")
    sut.add(item)
    let returnedItem = sut.item(at: 0)
    XCTAssertEqual(returnedItem.title, item.title)
  }

  func test_CheckItemAt_ChangesCounts() {
    sut.add(TodoItem(title: ""))
    sut.checkItem(at: 0)
    XCTAssertEqual(sut.toDoCount, 0)
    XCTAssertEqual(sut.doneCount, 1)
  }

  func test_CheckItemAt_RemovesItFromToDoItems() {
    let first = TodoItem(title: "First")
    let second = TodoItem(title: "Second")
    sut.add(first)
    sut.add(second)
    sut.checkItem(at: 0)
    XCTAssertEqual(sut.item(at: 0).title, "Second")
  }

  func test_DoneItemAt_ReturnsCheckedItem() {
    let item = TodoItem(title: "Foo")
    sut.add(item)
    sut.checkItem(at: 0)
    let returnedItem = sut.doneItem(at: 0)
    XCTAssertEqual(returnedItem.title, item.title)
  }

  func test_RemoveAll_ResultsInCountsBeZero() {
    sut.add(TodoItem(title: "Foo"))
    sut.add(TodoItem(title: "Bar"))
    sut.checkItem(at: 0)
    XCTAssertEqual(sut.toDoCount, 1)
    XCTAssertEqual(sut.doneCount, 1)
    sut.removeAll()

    XCTAssertEqual(sut.toDoCount, 0)
    XCTAssertEqual(sut.doneCount, 0)
  }

  func test_Add_WhenItemIsAlreadyAdded_DoesNotIncreaseCount() {
    sut.add(TodoItem(title: "Foo"))
    sut.add(TodoItem(title: "Foo"))

    XCTAssertEqual(sut.toDoCount, 1)
  }

  func test_ToDoItemsGetSerialized() {
    let firstItem = TodoItem(title: "First")
    sut?.add(firstItem)
    let secondItem = TodoItem(title: "Second")
    sut?.add(secondItem)
    NotificationCenter.default.post(
        name: UIApplication.willResignActiveNotification,
        object: nil)
    sut = nil
    XCTAssertNil(sut)
    sut = ItemManager()
    XCTAssertEqual(sut?.toDoCount, 2)
    XCTAssertEqual(sut?.item(at: 0), firstItem)
    XCTAssertEqual(sut?.item(at: 1), secondItem)
  }

  func test_DoneTodoItemsGetSerialized() {
    let firstItem = TodoItem(title: "First")
    sut.add(firstItem)
    let secondItem = TodoItem(title: "Second")
    sut.add(secondItem)
    sut.checkItem(at: 0)
    NotificationCenter.default.post(
        name: UIApplication.willResignActiveNotification,
        object: nil)
    sut = nil
    XCTAssertNil(sut)
    sut = ItemManager()
    XCTAssertEqual(sut.toDoCount, 1, "TodoCount should be 1")
    XCTAssertEqual(sut.doneCount, 1, "doneCount should be 1")

  }
}
