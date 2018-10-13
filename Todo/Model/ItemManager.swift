//
// Created by Katherine Ebel on 10/13/18.
// Copyright (c) 2018 Katherine Ebel. All rights reserved.
//

import Foundation

class ItemManager {
  var toDoCount: Int { return toDoItems.count }
  var doneCount: Int { return doneItems.count }
  private var toDoItems: [TodoItem] = []
  private var doneItems: [TodoItem] = []
  func add(_ item: TodoItem) {
    toDoItems.append(item)
  }

  func item(at index: Int) -> TodoItem {
    return toDoItems[index]
  }

  func checkItem(at index: Int) {
    let item = toDoItems.remove(at: index)
    doneItems.append(item)
  }

  func doneItem(at index: Int) -> TodoItem {
    return doneItems[index]
  }
}
