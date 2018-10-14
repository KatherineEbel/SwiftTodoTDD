//
//  InputViewController.swift
//  Todo
//
//  Created by Katherine Ebel on 10/14/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {
  @IBOutlet var titleTextField: UITextField!
  @IBOutlet var dateTextField: UITextField!
  @IBOutlet var locationTextField: UITextField!
  @IBOutlet var addressTextField: UITextField!
  @IBOutlet var descriptionTextField: UITextField!
  @IBOutlet var saveButton: UIButton!
  @IBOutlet var cancelButton: UIButton!
  
  lazy var geocoder = CLGeocoder()
  var itemManager: ItemManager?
  lazy var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter
  }()
  
  func save() {
    guard let titleString = titleTextField.text, titleString.count > 0 else { return }
    let date: Date?
    if let dateText = self.dateTextField.text, dateText.count > 0 {
      date = dateFormatter.date(from: dateText)
    } else {
      date = nil
    }
    
    let descriptionString = descriptionTextField.text
    if let locationName = locationTextField.text, locationName.count > 0 {
      if let address = addressTextField.text, address.count > 0 {
        geocoder.geocodeAddressString(address) {
          [unowned self] (placemarks, error) -> Void in
          let placemark = placemarks?.first
          
          let item = TodoItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: Location(name: locationName, coordinate: placemark?.location?.coordinate))
          self.itemManager?.add(item)
          
        }
      }
    } else {
      let item = TodoItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: nil)
      self.itemManager?.add(item)
    }
  }
  @IBAction func save(_ sender: UIButton) {
    save()
    dismiss(animated: true)
  }
}
