//
// Created by Katherine Ebel on 10/13/18.
// Copyright (c) 2018 Katherine Ebel. All rights reserved.
//

import UIKit

class ItemManager: NSObject {
  var toDoCount: Int { return toDoItems.count }
  var doneCount: Int { return doneItems.count }
  private var toDoItems: [TodoItem] = []
  private var doneItems: [TodoItem] = []
  var toDoPathURL: URL {
    let fileURLs = FileManager.default
        .urls(for: .documentDirectory,
        in: .userDomainMask)
    guard let documentURL = fileURLs.first else {
      print("Something went wrong. Documents url could not be found")
      fatalError()
    }
    return documentURL.appendingPathComponent("toDoItems.plist")
  }

  override init() {
    super.init()

    NotificationCenter.default.addObserver(
        self, selector: #selector(save),
        name: UIApplication.willResignActiveNotification,
        object: nil)
    if let nsToDoItems = NSArray(contentsOf: toDoPathURL) {
      for dict in nsToDoItems {
        if let toDoItem = TodoItem(dict: dict as! [String: Any]) {
          toDoItem.checked
              ? doneItems.append(toDoItem)
              : toDoItems.append(toDoItem)
        }
      }
    }
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
    save()
  }

  func add(_ item: TodoItem) {
    guard !toDoItems.contains(item) else { return }
    toDoItems.append(item)
  }

  func item(at index: Int) -> TodoItem {
    return toDoItems[index]
  }

  func checkItem(at index: Int) {
    var item = toDoItems.remove(at: index)
    item.checked = true
    doneItems.append(item)
  }

  func uncheckItem(at index: Int) {
    var item = doneItems.remove(at: index)
    item.checked = false
    toDoItems.append(item)
  }
  func doneItem(at index: Int) -> TodoItem {
    return doneItems[index]
  }

  func removeAll() {
    toDoItems.removeAll()
    doneItems.removeAll()
  }

  @objc func save() {
    var nsToDoItems = toDoItems.map { $0.plistDict }
    let nsDoneItems = doneItems.map { $0.plistDict }
    nsToDoItems.append(contentsOf: nsDoneItems)
    guard nsToDoItems.count > 0 else {
      try? FileManager.default.removeItem(at: toDoPathURL)
      return
    }
    do {
      let plistData = try PropertyListSerialization.data(
          fromPropertyList: nsToDoItems,
          format: PropertyListSerialization.PropertyListFormat.xml,
          options: PropertyListSerialization.WriteOptions(0))
      try plistData.write(to: toDoPathURL, options: Data.WritingOptions.atomic)
    } catch {
      print(error)
    }
  }
}
