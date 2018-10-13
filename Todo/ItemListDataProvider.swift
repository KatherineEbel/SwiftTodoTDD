//
// Created by Katherine Ebel on 10/13/18.
// Copyright (c) 2018 Katherine Ebel. All rights reserved.
//

import UIKit

enum Section: Int {
  case toDo
  case done
}

class ItemListDataProvider: NSObject, UITableViewDataSource {

  var itemManager: ItemManager?

  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let itemManager = itemManager else { return 0 }
    guard let itemSection = Section(rawValue: section) else { fatalError() }

    let numRows: Int
    switch itemSection {
      case .toDo: numRows = itemManager.toDoCount
      case .done: numRows = itemManager.doneCount
    }
    return numRows
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell

    guard let itemManager = itemManager else { fatalError() }
    guard let section = Section(rawValue: indexPath.section) else { fatalError() }

    let item: TodoItem
    switch section {
      case .toDo: item = itemManager.item(at: indexPath.row)
      case .done: item = itemManager.doneItem(at: indexPath.row)
    }

    cell.configCell(with: item)

    return cell
  }
}
