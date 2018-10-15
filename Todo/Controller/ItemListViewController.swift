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

    NotificationCenter.default.addObserver(
        self,
        selector: #selector(showDetails(sender:)),
        name: NSNotification.Name("ItemSelectedNotification"),
        object: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView?.reloadData()
  }

  @objc func showDetails(sender: NSNotification) {
    guard let index = sender.userInfo?["index"] as? Int else {
      fatalError()
    }
    if let nextVC = storyboard?.instantiateViewController(
        withIdentifier: "DetailViewController") as? DetailViewController {
      nextVC.itemInfo = (itemManager, index)
      navigationController?.pushViewController(
          nextVC,
          animated: true)
    }
  }
  @IBAction func addItem(_ sender: UIBarButtonItem) {
    if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "InputViewController") as? InputViewController {
      nextViewController.itemManager = itemManager
      present(nextViewController, animated: true, completion: nil)
    }
  }
  
}
