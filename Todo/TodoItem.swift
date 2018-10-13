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
  
  init(title: String, itemDescription: String? = nil) {
    self.title = title
    self.itemDescription = itemDescription
  }
}
