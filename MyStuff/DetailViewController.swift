//
//  DetailViewController.swift
//  MyStuff
//
//  Created by John Alstru on 9/2/15.
//  Copyright (c) 2015 nilpoint.sample. All rights reserved.
//

import UIKit
import MobileCoreServices

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  @IBOutlet var nameField: UITextField!
  @IBOutlet var locationField: UITextField!
  @IBOutlet var imageView: UIImageView!
  
  @IBAction func choosePicture(_: AnyObject!) {
    if detailItem == nil {
      return
    }
    
    let hasPhotos = UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)
    let hasCamera = UIImagePickerController.isSourceTypeAvailable(.Camera)
    
    switch (hasPhotos, hasCamera) {
    case (true, true):
      let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
      alert.addAction(UIAlertAction(
        title: "Take a Picture",
        style: .Default,
        handler: {(_) in
          self.presentImagePicker(.Camera)
      }))
      alert.addAction(UIAlertAction(
        title: "Choose a Photo",
        style: .Default,
        handler: {(_) in
          self.presentImagePicker(.PhotoLibrary)
      }))
      alert.addAction(UIAlertAction(
        title: "Cancel",
        style: .Cancel,
        handler: nil))
      if let popover = alert.popoverPresentationController {
        popover.sourceView = imageView
        popover.sourceRect = imageView.bounds
        popover.permittedArrowDirections = ( .Up | .Down)
      }
      presentViewController(alert, animated: true, completion: nil)
      break
    case (true, false):
      presentImagePicker(.PhotoLibrary)
      break
    case (false, true):
      presentImagePicker(.Camera)
      break
    default:
      break
    }
  }

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
  
  func presentImagePicker(source: UIImagePickerControllerSourceType) {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = source
    imagePicker.mediaTypes = [kUTTypeImage as String]
    imagePicker.delegate = self
    presentViewController(imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    var image: UIImage! = info[UIImagePickerControllerEditedImage] as? UIImage
    if image == nil {
      image = info[UIImagePickerControllerOriginalImage] as! UIImage
    }
    
    if picker.sourceType == .Camera {
      UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    detailItem?.image = image
    imageView.image = image
    dismissViewControllerAnimated(true, completion: nil)
  }

}

