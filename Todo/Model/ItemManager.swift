//
// Created by Katherine Ebel on 10/13/18.
// Copyright (c) 2018 Katherine Ebel. All rights reserved.
//

import Foundation

class ItemManager: NSObject {
  var toDoCount: Int { return toDoItems.count }
  var doneCount: Int { return doneItems.count }
  private var toDoItems: [TodoItem] = []
  private var doneItems: [TodoItem] = []

  func add(_ item: TodoItem) {
    guard !toDoItems.contains(item) else { return }
    toDoItems.append(item)
  }

  func item(at index: Int) -> TodoItem {
    return toDoItems[index]
  }

  func checkItem(at index: Int) {
    let item = toDoItems.remove(at: index)
    doneItems.append(item)
  }

  func uncheckItem(at index: Int) {
    let item = doneItems.remove(at: index)
    toDoItems.append(item)
  }
  func doneItem(at index: Int) -> TodoItem {
    return doneItems[index]
  }

  func removeAll() {
    toDoItems.removeAll()
    doneItems.removeAll()
  }
}
