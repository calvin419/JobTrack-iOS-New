//
//  ApplicationsList.swift
//  JobTrack
//
//  Created by Connor Alvin on 5/7/18.
//  Copyright © 2018 Connor Alvin. All rights reserved.
//

import UIKit

class ApplicationsList: UITableViewController {

    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = documentsDirectory.appendingPathComponent("savedApps")
    
    var companiesApplied = [SubmittedApp]()
    var ourDefaults = UserDefaults.standard
    var currSort: Int?

    override func viewDidLoad() {
        self.title = "Submitted Applications"
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.49, blue:0.89, alpha:1.0)

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(modifySort(_:)))
        self.navigationItem.leftBarButtonItem = sortButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        if (ourDefaults.object(forKey: "lastUpdate") as? Date) != nil {
            if let tempArr = NSKeyedUnarchiver.unarchiveObject(withFile: ApplicationsList.archiveURL.path) as? [SubmittedApp] {
                companiesApplied = tempArr
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
        performSegue(withIdentifier: "addApplication", sender: nil)
    }
    @objc func modifySort(_ sender: Any) {
        performSegue(withIdentifier: "modifySort", sender: nil)
    }
    
    func addCompany(newCompany : SubmittedApp) {
        companiesApplied.append(newCompany)
        updatePersistentStorage()
    }
    func editCompany(newCompany: SubmittedApp, indexPath: IndexPath) {
        companiesApplied[indexPath.row].company = newCompany.company
        companiesApplied[indexPath.row].jobTitle = newCompany.jobTitle
        companiesApplied[indexPath.row].location = newCompany.location
        companiesApplied[indexPath.row].dateApplied = newCompany.dateApplied
        companiesApplied[indexPath.row].status = newCompany.status
    }
    
    func updatePersistentStorage() {
        // persist data
        NSKeyedArchiver.archiveRootObject(companiesApplied, toFile: ApplicationsList.archiveURL.path)
        
        // timestamp last update
        ourDefaults.set(Date(), forKey: "lastUpdate")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return companiesApplied.count
    }

    @IBAction func unwindFromAdd(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    @IBAction func unwindFromCancel(segue: UIStoryboardSegue) {
    }
    @IBAction func unwindfromSort(segue: UIStoryboardSegue) {
        updatePersistentStorage()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appCell", for: indexPath) as? ApplicationCell

        // Configure the cell...
        let thisApp = companiesApplied[(indexPath).row]
        cell?.companyLabel?.text = thisApp.company
        cell?.titleLabel?.text = thisApp.jobTitle
        cell?.locationLabel?.text = thisApp.location
        cell?.dateLabel?.text = thisApp.dateApplied
        cell?.statusLabel?.text = thisApp.status

        return cell!
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            companiesApplied.remove(at: (indexPath).row)
            tableView.reloadData()
            updatePersistentStorage()
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editApp" {
            let destVC = segue.destination as? EditAppVC
            let selectedIndexPath = tableView.indexPathForSelectedRow
            destVC?.shownApp = companiesApplied[((selectedIndexPath)?.row)!]
            destVC?.indexPath = selectedIndexPath
        } else if segue.identifier == "modifySort" {
            let destVC = segue.destination as? SortVC
            destVC?.typeNum = 2
            destVC?.currSort = currSort ?? 0
        }
    }

}
