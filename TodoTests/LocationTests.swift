//
//  LocationTests.swift
//  TodoTests
//
//  Created by Katherine Ebel on 10/13/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import XCTest
@testable import Todo
import CoreLocation

class LocationTests: XCTestCase {
  
  func test_Init_SetsCoordinate() {
    let coordinate = CLLocationCoordinate2D(latitude: 1,
                                            longitude: 2)
    let location = Location(name: "", coordinate: coordinate)
    XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
    XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
  }

  func test_Init_SetsName() {
    let location = Location(name: "Foo")
    XCTAssertEqual(location.name, "Foo")
  }
}
