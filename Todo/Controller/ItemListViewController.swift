//
// Created by Katherine Ebel on 10/13/18.
// Copyright (c) 2018 Katherine Ebel. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
  @IBOutlet var tableView: UITableView?
  @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate & ItemManagerSettable)!
  let itemManager = ItemManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    dataProvider.itemManager = itemManager
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView?.reloadData()
  }
  @IBAction func addItem(_ sender: UIBarButtonItem) {
    if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "InputViewController") as? InputViewController {
      nextViewController.itemManager = itemManager
      present(nextViewController, animated: true, completion: nil)
    }
  }
  
}
