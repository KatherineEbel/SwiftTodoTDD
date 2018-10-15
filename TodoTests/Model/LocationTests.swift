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

  func test_EqualLocations_AreEqual() {
    let location1 = Location(name: "Foo")
    let location2 = Location(name: "Foo")
    XCTAssertEqual(location1, location2)
  }

  func test_Locations_WhenLatitudeDiffers_AreNotEqual() {
    assertLocationNotEqualWith(firstName: "Foo", firstLongLat: (0.0, 1.0), secondName: "Foo", secondLongLat: (1.0, 1.0))
  }

  func test_Locations_WhenLongitudeDiffers_AreNotEqual() {
    assertLocationNotEqualWith(firstName: "Foo", firstLongLat: (1.0, 0.0), secondName: "Foo", secondLongLat: (1.0, 1.0))
  }

  func test_Locations_WhenOnlyOneHasCoordinate_AreNotEqual() {
    assertLocationNotEqualWith(firstName: "Foo", firstLongLat: (0.0, 0.0), secondName: "Foo", secondLongLat: nil)
  }

  func test_Locations_WhenNamesDiffer_AreNotEqual() {
    assertLocationNotEqualWith(firstName: "Foo", firstLongLat: nil, secondName: "Bar", secondLongLat: nil)
  }

  func test_CanBeSerializedAndDeserialized() {
    let location = Location(name: "Home", coordinate: CLLocationCoordinate2DMake(50.0, 6.0))
    let dict = location.plistDict
    XCTAssertNotNil(dict)
    let recreatedLocation = Location(dict: dict)
    XCTAssertEqual(location, recreatedLocation)
  }

  private func assertLocationNotEqualWith(firstName: String,
                                          firstLongLat: (Double, Double)?,
                                          secondName: String,
                                          secondLongLat: (Double, Double)?,
                                          line: UInt = #line) {

    var firstCoord: CLLocationCoordinate2D? = nil
    if let firstLongLat = firstLongLat {
      firstCoord = CLLocationCoordinate2D(latitude: firstLongLat.0, longitude: firstLongLat.1)
    }
    let firstLocation = Location(name: firstName, coordinate: firstCoord)
    var secondCoord: CLLocationCoordinate2D? = nil
    if let secondLongLat = secondLongLat {
      secondCoord = CLLocationCoordinate2D(latitude: secondLongLat.0, longitude: secondLongLat.1)
    }
    let secondLocation = Location(name: secondName, coordinate: secondCoord)
    XCTAssertNotEqual(firstLocation, secondLocation, line: line)
  }
}
