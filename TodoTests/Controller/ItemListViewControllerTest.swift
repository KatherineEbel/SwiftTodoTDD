//
// Created by Katherine Ebel on 10/13/18.
// Copyright (c) 2018 Katherine Ebel. All rights reserved.
//

import XCTest
import UIKit
@testable import Todo


class ItemListViewControllerTest: XCTestCase {
  var sut: ItemListViewController!
  var addButton: UIBarButtonItem!
  var action: Selector!

  override func setUp() {
    super.setUp()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
    sut = (viewController as! ItemListViewController)
    sut.loadViewIfNeeded()
    addButton = sut.navigationItem.rightBarButtonItem
    action = addButton.action
    UIApplication.shared.keyWindow?.rootViewController = sut
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
  
  func test_ItemListViewController_HasAddBarButtonWithSelfAsTarget() {
    let target = sut.navigationItem.rightBarButtonItem?.target
    XCTAssertEqual(target as? UIViewController, sut)
  }
  
  func test_Add_Item_PresentsAddItemViewController() {
    XCTAssertNil(sut.presentedViewController)
    guard let addButton = addButton else { XCTFail(); return }
    guard let action = action else { XCTFail(); return }
    sut.performSelector(onMainThread: action, with: addButton, waitUntilDone: true)
    XCTAssertNotNil(sut.presentedViewController)
    XCTAssertTrue(sut.presentedViewController is InputViewController)
    
    let inputViewController = sut.presentedViewController as! InputViewController
    XCTAssertNotNil(inputViewController.titleTextField, "titleTextField should not be nil")
  }
  
  func testItemListVC_SharesItemManagerWithInputVC() {
    guard let addButton = addButton else { XCTFail(); return }
    guard let action = action else { XCTFail(); return }
    sut.performSelector(onMainThread: action, with: addButton, waitUntilDone: true)
    
    guard let inputViewController = sut.presentedViewController as? InputViewController else { XCTFail(); return }
    guard let inputItemManager = inputViewController.itemManager else { XCTFail(); return }
    XCTAssertTrue(sut.itemManager === inputItemManager)
  }
  
  func test_ViewDidLoad_SetsItemManagerToDataProvider() {
    XCTAssertTrue(sut.itemManager === sut.dataProvider.itemManager)
  }
  
  func test_tableViewReloaded_onViewWillAppear() {
    sut = ItemListViewController()
    let mockTableView = MockTableView()
    sut.dataProvider = ItemListDataProvider()
    sut.tableView = mockTableView
    
    sut.beginAppearanceTransition(true, animated: true)
    sut.endAppearanceTransition()
    print(mockTableView.reloadDataCalled)

  }
}

extension ItemListViewControllerTest {
  class MockTableView: UITableView {
    var reloadDataCalled = false
    override func reloadData() {
      reloadDataCalled = true
    }
  }
}

