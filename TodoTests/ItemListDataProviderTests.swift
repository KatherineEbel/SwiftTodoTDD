//
// Created by Katherine Ebel on 10/13/18.
// Copyright (c) 2018 Katherine Ebel. All rights reserved.
//

import XCTest
import UIKit
@testable import Todo

class ItemListDataProviderTests: XCTestCase {
  var sut: ItemListDataProvider!
  var tableView: UITableView!
  var controller: ItemListViewController!

  override func setUp() {
    super.setUp()
    sut = ItemListDataProvider()
    sut.itemManager = ItemManager()
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    controller = storyBoard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
    controller.loadViewIfNeeded()
    tableView = controller.tableView
    tableView.dataSource = sut

  }

  func test_NumberOfSections_IsTwo() {
    let numberOfSections = tableView.numberOfSections
    XCTAssertEqual(numberOfSections, 2, "should have 2 sections")
  }

  func test_NumberOfRows_Section1_IsToDoCount() {
    sut.itemManager?.add(TodoItem(title: "Foo"))
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)

    sut.itemManager?.add(TodoItem(title: "Bar"))
    tableView.reloadData()
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)


  }

  func test_NumberOfRows_Section2_IsToDoDoneCount() {
    sut.itemManager?.add(TodoItem(title: "Foo"))
    sut.itemManager?.add(TodoItem(title: "Bar"))
    sut.itemManager?.checkItem(at: 0)
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)

    sut.itemManager?.checkItem(at: 0)
    tableView.reloadData()

    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
  }

  func test_CellForRow_ReturnsItemCell() {
    sut.itemManager?.add(TodoItem(title: "Foo"))
    tableView.reloadData()

    let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
    XCTAssertTrue(cell is ItemCell)
  }

  func test_CellForRow_DequeuesCellFromTableView() {
    let mockTableView = MockTableView()
    mockTableView.dataSource = sut
    mockTableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
    sut.itemManager?.add(TodoItem(title: "foo"))
    mockTableView.reloadData()
    _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
    XCTAssertTrue(mockTableView.cellGotDequeued)
  }

  func test_CellForRow_CallsConfigCell() {
    let mockTableView = MockTableView.mockTableView(withDataSource: sut)
    let item = TodoItem(title: "foo")
    sut.itemManager?.add(item)
    mockTableView.reloadData()

    let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
    XCTAssertEqual(cell.item, item)
  }

  func test_CellForRow_Section2_CallsConfigCellWithDoneItem() {
    let mockTableView = MockTableView.mockTableView(withDataSource: sut)
    sut.itemManager?.add(TodoItem(title: "Foo"))
    let second = TodoItem(title: "Bar")
    sut.itemManager?.add(second)
    sut.itemManager?.checkItem(at: 1)
    mockTableView.reloadData()

    let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
    XCTAssertEqual(cell.item, second)
  }
}

extension ItemListDataProviderTests {
  class MockTableView: UITableView {
    var cellGotDequeued = false

    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
      cellGotDequeued = true
      return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }

    class func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockTableView {
      let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 320, height: 480), style: .plain)
      mockTableView.dataSource = dataSource
      mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
      return mockTableView
    }
  }

  class MockItemCell: ItemCell {
    var item: TodoItem?

    override func configCell(with item: TodoItem) {
      self.item = item
    }

  }
}