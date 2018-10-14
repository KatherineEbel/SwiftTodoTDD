//
// Created by Katherine Ebel on 10/13/18.
// Copyright (c) 2018 Katherine Ebel. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
 
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var locationLabel: UILabel!
  @IBOutlet var dateLabel: UILabel!
  lazy var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
  }()
  
  func configCell(with item: TodoItem, checked: Bool = false) {
    if checked {
      let attributedString = NSAttributedString(string: item.title, attributes: [NSAttributedString.Key.strikethroughStyle:
        NSUnderlineStyle.single.rawValue])
      titleLabel.attributedText = attributedString
      locationLabel.text = nil
      dateLabel.text = nil
    } else {
      titleLabel.text = item.title
      if let timestamp = item.timestamp {
        let date = Date(timeIntervalSince1970: timestamp)
        dateLabel.text = dateFormatter.string(from: date)
      }
      locationLabel.text = item.location?.name ?? ""
    }

  }
}
