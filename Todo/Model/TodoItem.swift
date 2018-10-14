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
  
  init(title: String, itemDescription: String? = nil, timestamp: Double? = nil, location: Location? = nil) {
    self.title = title
    self.itemDescription = itemDescription
    self.timestamp = timestamp
    self.location = location
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

