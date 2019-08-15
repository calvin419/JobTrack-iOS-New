//
//  SearchResultsList.swift
//  JobTrack
//
//  Created by Connor Alvin on 5/7/18.
//  Copyright © 2018 Connor Alvin. All rights reserved.
//

import UIKit

class SearchResultsList: UITableViewController {

    var apiString = "http://jobs.github.com/positions.json?"
    
    var results = [SearchResult]()
    var descrips: String = ""
    var location: String = ""
    var type: Bool = true
    var currSort: Int?
    
    override func viewDidLoad() {
        
        self.title = "GitHub Search Results"
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.49, blue:0.89, alpha:1.0)

        let modifySearchButton = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(modifySearch(_:)))
        self.navigationItem.rightBarButtonItem = modifySearchButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(modifySort(_:)))
        self.navigationItem.leftBarButtonItem = sortButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let request = URLRequest(url: URL(string: apiString)!)
        
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let searchResults = try decoder.decode([SearchResult].self, from: data)
                    
                    self.results = searchResults
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }  catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }
    
    @objc func modifySearch(_ sender: Any) {
        performSegue(withIdentifier: "modifySearch", sender: nil)
    }
    @objc func modifySort(_ sender: Any) {
        performSegue(withIdentifier: "modifySort", sender: nil)
    }
    
    @IBAction func unwindFromApply(segue: UIStoryboardSegue) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let request = URLRequest(url: URL(string: apiString)!)
        
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let searchResults = try decoder.decode([SearchResult].self, from: data)
                    
                    self.results = searchResults
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }  catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()
        tableView.reloadData()
        apiString = "http://jobs.github.com/positions.json?"
        if descrips != "" {
            let dRange = descrips.startIndex ..< descrips.index(descrips.startIndex, offsetBy: 12)
            descrips.removeSubrange(dRange)
            descrips.removeLast()
            descrips = descrips.replacingOccurrences(of: "+", with: " ")
        }
        if location != "" {
            let lRange = location.startIndex ..< location.index(location.startIndex, offsetBy: 9)
            location.removeSubrange(lRange)
            location.removeLast()
            location = location.replacingOccurrences(of: "+", with: " ")
        }
    }
    
    @IBAction func unwindFromCancel(segue: UIStoryboardSegue) {
    }
    
    @IBAction func unwindfromSort(segue: UIStoryboardSegue) {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as? SearchResultCell

        let searchResult = results[indexPath.row]
        // Configure the cell...
        cell?.companyLabel?.text = searchResult.company
        cell?.titleLabel?.text = searchResult.title
        cell?.locationLabel?.text = searchResult.location
        cell?.typeLabel?.text = searchResult.type
        

        return cell!
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
        if segue.identifier == "modifySearch" {
            let destVC = segue.destination as? ModifySearchVC
            destVC?.newApiString = apiString
            destVC?.oldDescrip = descrips
            destVC?.oldLocation = location
            destVC?.oldType = type
        }
        else if segue.identifier == "showJobInfo" {
            let destVC = segue.destination as? JobInfoVC
            let selectedIndexPath = tableView.indexPathForSelectedRow
            let backButton = UIBarButtonItem()
            backButton.title = "Back"
            backButton.tintColor = UIColor.white
            navigationItem.backBarButtonItem = backButton
            destVC?.jobURL = results[(selectedIndexPath?.row)!].url
            destVC?.iconURL = results[(selectedIndexPath?.row)!].companyLogo
            destVC?.companyURL = results[(selectedIndexPath?.row)!].companyURL
            destVC?.company = results[(selectedIndexPath?.row)!].company
            destVC?.jobTitle = results[(selectedIndexPath?.row)!].title
            destVC?.location = results[(selectedIndexPath?.row)!].location
            destVC?.type = results[(selectedIndexPath?.row)!].type
        }
        else if segue.identifier == "modifySort" {
            let destVC = segue.destination as? SortVC
            destVC?.typeNum = 0
            destVC?.currSort = currSort ?? 0
        }
    }

}
