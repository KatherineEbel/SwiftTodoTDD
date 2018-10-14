//
// Created by Katherine Ebel on 10/13/18.
// Copyright (c) 2018 Katherine Ebel. All rights reserved.
//

import XCTest
import UIKit
@testable import Todo

class ItemCellTests: XCTestCase {

  var tableView: UITableView!
  let dataSource = FakeDataSource()
  var cell: ItemCell!

  override func setUp() {
    super.setUp()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
    controller.loadViewIfNeeded()
    tableView = controller.tableView
    tableView?.dataSource = dataSource
    cell = (tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell)
  }

  func test_HasNameLabel() {
    XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
  }

  func testHasLocationLabel() {
    XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
  }

  func testHasDateLabel() {
    XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))
  }

  func test_ConfigCell_SetsTitle() {
    cell.configCell(with: TodoItem(title: "Foo"))
    XCTAssertEqual(cell.titleLabel.text, "Foo")
  }

  func test_ConfigCell_SetsDate() {
    let date = cell.dateFormatter.date(from: "10/27/2018")
    let timestamp = date?.timeIntervalSince1970
    cell.configCell(with: TodoItem(title: "Foo", timestamp: timestamp))
    XCTAssertEqual(cell.dateLabel.text, "10/27/2018")
  }
  
  func test_ConfigCell_SetsLocation() {
    cell.configCell(with: TodoItem(title: "Foo", location: Location(name: "Bar")))
    XCTAssertEqual(cell.locationLabel.text, "Bar")
  }
  
  func test_Title_WhenItemIsChecked_IsStruckThrough
    () {
    let location = Location(name: "Bar")
    let item = TodoItem(title: "Foo", itemDescription: nil, timestamp: 1456150025, location: location)
    cell.configCell(with: item, checked: true)
    let attributedString = NSAttributedString(string: "Foo", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue ])
    
    XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
    XCTAssertNil(cell.locationLabel.text)
    XCTAssertNil(cell.dateLabel.text)
  }
}

extension ItemCellTests {
  class FakeDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      return UITableViewCell()
    }
  }
}
