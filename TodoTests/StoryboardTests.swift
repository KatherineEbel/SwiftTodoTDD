//
//  StoryboardTests.swift
//  TodoTests
//
//  Created by Katherine Ebel on 10/14/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import XCTest
@testable import Todo

class StoryboardTests: XCTestCase {

  func test_InitialViewController_IsItemListViewController() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
    let rootViewController = navigationController.viewControllers[0]
    XCTAssertTrue(rootViewController is ItemListViewController)
  }

}
