//
// Created by Katherine Ebel on 10/13/18.
// Copyright (c) 2018 Katherine Ebel. All rights reserved.
//

import XCTest
import UIKit
@testable import Todo


class ItemListViewControllerTest: XCTestCase {
  var sut: ItemListViewController!

  override func setUp() {
    super.setUp()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
    sut = viewController as! ItemListViewController
    sut.loadViewIfNeeded()
  }

  func test_TableViewIsNotNilAfterViewDidLoad() {
    XCTAssertNotNil(sut.tableView)
  }

  func test_LoadingView_SetsTableViewDataSource() {
    XCTAssertTrue(sut.tableView?.dataSource is ItemListDataProvider)

  }

  func test_LoadingView_SetsTableViewDelegate() {
    XCTAssertTrue(sut.tableView?.delegate is ItemListDataProvider)
  }

  func test_LoadingView_DataSourceEqualDelegate() {
    XCTAssertEqual(sut.tableView?.dataSource as? ItemListDataProvider,
                   sut.tableView?.delegate as? ItemListDataProvider)
  }
}
