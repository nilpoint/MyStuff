//
//  MasterViewController.swift
//  MyStuff
//
//  Created by John Alstru on 9/2/15.
//  Copyright (c) 2015 nilpoint.sample. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

  var detailViewController: DetailViewController? = nil
  var things = [
    MyWhatsit(name: "Gort", location: "den"),
    MyWhatsit(name: "Disappearing TARDIS mug", location: "kitchen"),
    MyWhatsit(name: "Robot USB drive", location: "office"),
    MyWhatsit(name: "Sad Robot USB hub", location: "office"),
    MyWhatsit(name: "Solar Powered Bunny", location: "office")
  ]

  override func awakeFromNib() {
    super.awakeFromNib()
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
        self.clearsSelectionOnViewWillAppear = false
        self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem()

    let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
    self.navigationItem.rightBarButtonItem = addButton
    if let split = self.splitViewController {
        let controllers = split.viewControllers
        self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func insertNewObject(sender: AnyObject) {
//    things.insert(NSDate(), atIndex: 0)
//    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//    self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
  }

  // MARK: - Segues

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    if segue.identifier == "showDetail" {
//        if let indexPath = self.tableView.indexPathForSelectedRow() {
//            let object = things[indexPath.row] as! NSDate
//            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
//            controller.detailItem = object
//            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//            controller.navigationItem.leftItemsSupplementBackButton = true
//        }
//    }
  }

  // MARK: - Table View

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return things.count
  }

  // This is your rubber stamp. 
  // This function is called every time the table view wants to draw a row.
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

    let thing = things[indexPath.row] as MyWhatsit
    cell.textLabel?.text = thing.name
    cell.detailTextLabel?.text = thing.location
    return cell
  }

  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }

  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
        things.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
  }


}

