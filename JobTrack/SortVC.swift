//
//  SortVC.swift
//  JobTrack
//
//  Created by Connor Alvin on 6/9/18.
//  Copyright © 2018 Connor Alvin. All rights reserved.
//

import UIKit

class SortVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    var typeNum: Int?
    var currSort: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.selectRow(currSort!, inComponent: 0, animated: false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if row == 0 {
                return "Company"
            } else if row == 1 {
                return "Title"
            } else if row == 2 {
                return "Location"
            } else if row == 3 {
                if typeNum == 0 || typeNum == 1 {
                    return "Type"
                } else if typeNum == 2 {
                    return "Most Recent"
                }
            }
            return nil
        }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "unwindFromSort" {
            if typeNum == 0 {
                let destVC = segue.destination as? SearchResultsList
                if pickerView.selectedRow(inComponent: 0) == 0 {
                    destVC?.results.sort(by: { (s1, s2) in return s1.company! < s2.company!})
                    destVC?.tableView.reloadData()
                    destVC?.currSort = 0
                } else if pickerView.selectedRow(inComponent: 0) == 1 {
                    destVC?.results.sort(by: { (s1, s2) in return s1.title! < s2.title!})
                    destVC?.tableView.reloadData()
                    destVC?.currSort = 1
                } else if pickerView.selectedRow(inComponent: 0) == 2 {
                    destVC?.results.sort(by: { (s1, s2) in return s1.location! < s2.location!})
                    destVC?.tableView.reloadData()
                    destVC?.currSort = 2
                } else if pickerView.selectedRow(inComponent: 0) == 3 {
                    destVC?.results.sort(by: { (s1, s2) in return s1.type! < s2.type!})
                    destVC?.tableView.reloadData()
                    destVC?.currSort = 3
                }
            } else if typeNum == 1 {
                let destVC = segue.destination as? ToApplyList
                if pickerView.selectedRow(inComponent: 0) == 0 {
                    destVC?.toApply.sort(by: { (s1, s2) in return s1.company! < s2.company!})
                    destVC?.tableView.reloadData()
                    destVC?.currSort = 0
                } else if pickerView.selectedRow(inComponent: 0) == 1 {
                    destVC?.toApply.sort(by: { (s1, s2) in return s1.title! < s2.title!})
                    destVC?.tableView.reloadData()
                    destVC?.currSort = 1
                } else if pickerView.selectedRow(inComponent: 0) == 2 {
                    destVC?.toApply.sort(by: { (s1, s2) in return s1.location! < s2.location!})
                    destVC?.tableView.reloadData()
                    destVC?.currSort = 2
                } else if pickerView.selectedRow(inComponent: 0) == 3 {
                    destVC?.toApply.sort(by: { (s1, s2) in return s1.type! < s2.type!})
                    destVC?.tableView.reloadData()
                    destVC?.currSort = 3
                }
            } else if typeNum == 2 {
                let destVC = segue.destination as? ApplicationsList
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                if pickerView.selectedRow(inComponent: 0) == 0 {
                    destVC?.companiesApplied.sort(by: { (s1, s2) in return s1.company < s2.company})
                    destVC?.tableView.reloadData()
                    destVC?.currSort = 0
                } else if pickerView.selectedRow(inComponent: 0) == 1 {
                    destVC?.companiesApplied.sort(by: { (s1, s2) in return s1.jobTitle < s2.jobTitle})
                    destVC?.tableView.reloadData()
                    destVC?.currSort = 1
                } else if pickerView.selectedRow(inComponent: 0) == 2 {
                    destVC?.companiesApplied.sort(by: { (s1, s2) in return s1.location < s2.location})
                    destVC?.tableView.reloadData()
                    destVC?.currSort = 2
                } else if pickerView.selectedRow(inComponent: 0) == 3 {
                    destVC?.companiesApplied.sort(by: { (s1, s2) in return (dateFormatter.date(from: s1.dateApplied))! > (dateFormatter.date(from: s2.dateApplied))!})
                    destVC?.tableView.reloadData()
                    destVC?.currSort = 3
                }
            }
        }
    }
}
