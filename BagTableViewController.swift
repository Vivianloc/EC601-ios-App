//
//  BagTableViewController.swift
//  BagTracker
//
//  Created by 韩猷 on 10/2/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class BagTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var bags = [Bag]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved meals, otherwise load sample data.
        if let savedBags = loadBags() {
            bags += savedBags
        }
        else {
            // Load the sample data.
            loadSampleBags()
        }
        
        // Load the sample data.
        loadSampleBags()
    }
    
    func loadSampleBags() {
        let photo1 = UIImage(named: "Balenciaga")!
        let bag1 = Bag(name: "Balenciaga", photo: photo1, rating: 4)!
        
        let photo2 = UIImage(named: "Loewe")!
        let bag2 = Bag(name: "Loewe", photo: photo2, rating: 5)!
        
        let photo3 = UIImage(named: "LV")!
        let bag3 = Bag(name: "LV", photo: photo3, rating: 3)!
        
        bags += [bag1, bag2, bag3]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bags.count
    }

    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BagTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BagTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let bag = bags[indexPath.row]
        
        cell.nameLabel.text = bag.name
        cell.photoImageView.image = bag.photo
        cell.ratingControl.rating = bag.rating
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            bags.removeAtIndex(indexPath.row)
            saveBags()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

     
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let bagDetailViewController = segue.destinationViewController as! BagViewController
            
            // Get the cell that generated this segue.
            if let selectedBagCell = sender as? BagTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedBagCell)!
                let selectedBag = bags[indexPath.row]
                bagDetailViewController.bag = selectedBag
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new meal.")
        }
    }
 
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? BagViewController, bag = sourceViewController.bag {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                bags[selectedIndexPath.row] = bag
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else {
                // Add a new bag.
                let newIndexPath = NSIndexPath(forRow: bags.count, inSection: 0)
                bags.append(bag)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the bags.
            saveBags()
        }
    }
    
    // MARK: NSCoding
    func saveBags() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(bags, toFile: Bag.ArchiveURL!.path!)
        if !isSuccessfulSave {
            print("Failed to save bags...")
        }
    }
    
    func loadBags() -> [Bag]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Bag.ArchiveURL!.path!) as? [Bag]
    }

}
