//
// Created by Katherine Ebel on 10/14/18.
// Copyright (c) 2018 Katherine Ebel. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var locationLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var mapView: MKMapView!
  var itemInfo: (itemManager: ItemManager, itemIndex: Int)?
  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    guard let itemInfo = itemInfo else { return }
    let item = itemInfo.itemManager.item(at: itemInfo.itemIndex)
    titleLabel.text = item.title
    locationLabel.text = item.location?.name
    descriptionLabel.text = item.itemDescription
    
    if let timestamp = item.timestamp {
      let date = Date(timeIntervalSince1970: timestamp)
      dateLabel.text = dateFormatter.string(from: date)
    }
    
    if let coordinate = item.location?.coordinate {
      let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
      mapView.region = region
    }
  }
  
  func checkItem() {
    if let itemInfo = itemInfo {
      itemInfo.itemManager.checkItem(at: itemInfo.itemIndex)
    }
  }
}
