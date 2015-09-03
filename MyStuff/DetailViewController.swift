//
//  DetailViewController.swift
//  MyStuff
//
//  Created by John Alstru on 9/2/15.
//  Copyright (c) 2015 nilpoint.sample. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet var nameField: UITextField!
  @IBOutlet var locationField: UITextField!
  @IBOutlet var imageView: UIImageView!

  var detailItem: MyWhatsit? {
    didSet {
        // Update the view.
        self.configureView()
    }
  }

  func configureView() {
    // Update the user interface for the detail item.
    if let detail = self.detailItem {
        if nameField != nil {
            nameField.text = detail.name
          locationField.text = detail.location
          imageView.image = detail.viewImage
        }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.configureView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func changeDetail(sender: AnyObject) {
    if sender === nameField {
      detailItem?.name = nameField.text
    } else if sender === locationField {
      detailItem?.location = locationField.text
    }
  }

}

