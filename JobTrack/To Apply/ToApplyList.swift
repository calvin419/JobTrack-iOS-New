//
//  ToApplyList.swift
//  JobTrack
//
//  Created by Connor Alvin on 5/7/18.
//  Copyright © 2018 Connor Alvin. All rights reserved.
//

import UIKit

class ToApplyList: UITableViewController {
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = documentsDirectory.appendingPathComponent("savedFutJobs")
    
    var toApply = [SearchResult]()
    var ourDefaults = UserDefaults.standard
    var currSort: Int?
    var submitIndex: IndexPath?
    
    override func viewDidLoad() {
        self.title = "To Apply"
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.49, blue:0.89, alpha:1.0)
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(modifySort(_:)))
        self.navigationItem.leftBarButtonItem = sortButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        if (ourDefaults.object(forKey: "lastUpdate") as? Date) != nil {
            
            if let tempArr = NSKeyedUnarchiver.unarchiveObject(withFile: ToApplyList.archiveURL.path) as? [SearchResult] {
                toApply = tempArr
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    @objc func insertNewObject(_ sender: Any) {
        performSegue(withIdentifier: "addFutApp", sender: nil)
    }
    @objc func modifySort(_ sender: Any) {
        performSegue(withIdentifier: "modifySort", sender: nil)
        
    }

    func addCompany(newCompany : SearchResult) {
        toApply.append(newCompany)
        updatePersistentStorage()
    }
    
    func editCompany(newCompany: SearchResult, indexPath: IndexPath) {
        toApply[indexPath.row].company = newCompany.company
        toApply[indexPath.row].title = newCompany.title
        toApply[indexPath.row].location = newCompany.location
        toApply[indexPath.row].type = newCompany.type
    }
    func updatePersistentStorage() {
        // persist data
        NSKeyedArchiver.archiveRootObject(toApply, toFile: ToApplyList.archiveURL.path)
        
        // timestamp last update
        ourDefaults.set(Date(), forKey: "lastUpdate")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toApply.count
    }

    @IBAction func unwindFromAddFut(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    @IBAction func unwindFromCancelFut(segue: UIStoryboardSegue) {
    }

    @IBAction func unwindfromSort(segue: UIStoryboardSegue) {
        updatePersistentStorage()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toApplyCell", for: indexPath) as? ToApplyCell

        // Configure the cell...
        let thisNewApp = toApply[(indexPath).row]
        cell?.companyLabel?.text = thisNewApp.company
        cell?.titleLabel?.text = thisNewApp.title
        cell?.locationLabel?.text = thisNewApp.location
        cell?.typeLabel?.text = thisNewApp.type

        return cell!
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.toApply.remove(at: (indexPath).row)
            tableView.reloadData()
            self.updatePersistentStorage()
            success(true)
        })
        deleteAction.image = UIImage(named: "trash")
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    override func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let submitAction = UIContextualAction(style: .normal, title:  "Submitted", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.submitIndex = indexPath
            self.performSegue(withIdentifier: "setSubmitted", sender: nil)
            self.toApply.remove(at: ((indexPath).row))
            tableView.reloadData()
            self.updatePersistentStorage()
            success(true)
        })
        submitAction.image = UIImage(named: "checked_checkbox")
        submitAction.backgroundColor = .green
        
        return UISwipeActionsConfiguration(actions: [submitAction])
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editFutApp" {
            let destVC = segue.destination as? EditFutAppVC
            let selectedIndexPath = tableView.indexPathForSelectedRow
            destVC?.shownFutApp = toApply[((selectedIndexPath)?.row)!]
            destVC?.indexPath = selectedIndexPath
        } else if segue.identifier == "modifySort" {
            let destVC = segue.destination as? SortVC
            destVC?.typeNum = 1
            destVC?.currSort = currSort ?? 0
        } else if segue.identifier == "setSubmitted" {
            let destVC = segue.destination as? AddAppVC
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let date = Date()

            let dateString = dateFormatter.string(from: date)
            destVC?.appToSubmit = SubmittedApp(company: toApply[((submitIndex)?.row)!].company!, jobTitle: toApply[((submitIndex)?.row)!].title!, location: toApply[((submitIndex)?.row)!].location!, dateApplied: dateString, status: "Applied")
        }
    }

}
