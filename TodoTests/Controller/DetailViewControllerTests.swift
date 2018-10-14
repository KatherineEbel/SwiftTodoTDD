//
// Created by Katherine Ebel on 10/14/18.
// Copyright (c) 2018 Katherine Ebel. All rights reserved.
//

import XCTest
import UIKit
import CoreLocation
@testable import Todo

class DetailViewControllerTests: XCTestCase {

  var sut: DetailViewController!

  override func setUp() {
    super.setUp()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    sut = (storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController)
    sut.loadViewIfNeeded()
  }

  func test_HasTitleLabel() {
    let titleLabelIsSubView = sut.titleLabel?.isDescendant(of: sut.view) ?? false
    XCTAssertTrue(titleLabelIsSubView)
  }

  func test_HasMapView() {
    let mapViewIsSubView = sut.mapView?.isDescendant(of: sut.view) ?? false
    XCTAssertTrue(mapViewIsSubView)
  }
  
  func test_SettingItemInfo_SetsLabelText() {
    let coordinate = CLLocationCoordinate2DMake(51.2277, 6.7735)
    let location = Location(name: "Foo", coordinate: coordinate)
    let item = TodoItem(title: "Bar", itemDescription: "Baz", timestamp: 1456150025, location: location)
    let itemManager = ItemManager()
    itemManager.add(item)
    sut.itemInfo = (itemManager, 0)
    sut.beginAppearanceTransition(true, animated: true)
    sut.endAppearanceTransition()
    XCTAssertEqual(sut.titleLabel.text, "Bar")
    XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
    XCTAssertEqual(sut.locationLabel.text, "Foo")
    XCTAssertEqual(sut.descriptionLabel.text, "Baz")
    XCTAssertEqual(sut.mapView.centerCoordinate.latitude, coordinate.latitude, accuracy: 0.001)
    XCTAssertEqual(sut.mapView.centerCoordinate.longitude, coordinate.longitude, accuracy: 0.001)
    
  }
  
  func test_CheckItem_ChecksItemInItemManager() {
    let itemManager = ItemManager()
    let item = TodoItem(title: "Foo")
    itemManager.add(item)
    sut.itemInfo = (itemManager, 0)
    sut.checkItem()
    XCTAssertEqual(itemManager.toDoCount, 0)
    XCTAssertEqual(itemManager.doneCount, 1)
  }
}
