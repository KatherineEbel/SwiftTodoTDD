//
// Created by Katherine Ebel on 10/13/18.
// Copyright (c) 2018 Katherine Ebel. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
  @IBOutlet var tableView: UITableView?
  @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)!

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
