//
//  TodoItem.swift
//  Todo
//
//  Created by Katherine Ebel on 10/13/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import Foundation

struct TodoItem {
  let title: String
  let itemDescription: String?
  let timestamp: Double?
  let location: Location?
  var checked: Bool = false

  private let titleKey = "titleKey"
  private let itemDescriptionKey = "itemDescriptionKey"
  private let timestampKey = "timestampKey"
  private let locationKey = "locationKey"
  private let isCheckedKey = "isCheckedKey"
  var plistDict: [String: Any] {
    var dict = [String:Any]()
    dict[titleKey] = title
    dict[itemDescriptionKey] = itemDescription
    dict[timestampKey] = timestamp
    dict[isCheckedKey] = checked
    if let location = location {
      let locationDict = location.plistDict
      dict[locationKey] = locationDict
    }
    return dict
  }
  
  init(title: String, itemDescription: String? = nil, timestamp: Double? = nil, location: Location? = nil) {
    self.title = title
    self.itemDescription = itemDescription
    self.timestamp = timestamp
    self.location = location
  }

  init?(dict: [String:Any]) {
    guard let title = dict[titleKey] as? String else {
      return nil
    }
    self.title = title
    self.itemDescription = dict[itemDescriptionKey] as? String
    self.timestamp = dict[timestampKey] as? Double
    self.checked = dict[isCheckedKey] as? Bool ?? false
    if let locationDict = dict[locationKey] as? [String:Any] {
      self.location = Location(dict: locationDict)
    } else {
      self.location = nil
    }
  }
}

extension TodoItem: Equatable {}

func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
  if lhs.title != rhs.title {
    return false
  }
  if lhs.location != rhs.location {
    return false
  }
  if lhs.timestamp != rhs.timestamp {
    if let leftStamp = lhs.timestamp, let rightStamp = rhs.timestamp {
      return abs(leftStamp - rightStamp) < 100_000
    }
    return false
  }
  if lhs.itemDescription != rhs.itemDescription {
    return false
  }
  return true
}

