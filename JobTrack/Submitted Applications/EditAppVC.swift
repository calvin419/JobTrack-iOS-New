//
//  EditAppVC.swift
//  JobTrack
//
//  Created by Connor Alvin on 5/12/18.
//  Copyright © 2018 Connor Alvin. All rights reserved.
//

import UIKit

class EditAppVC: UIViewController {

    @IBOutlet weak var companyTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var statusTF: UITextField!
    
    var shownApp: SubmittedApp?
    var indexPath: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        companyTF.text = shownApp?.company
        titleTF.text = shownApp?.jobTitle
        locationTF.text = shownApp?.location
        dateTF.text = shownApp?.dateApplied
        statusTF.text = shownApp?.status
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "unwindFromSave" {
            let destVC = segue.destination as? ApplicationsList
            let newCompany = SubmittedApp(company: companyTF.text!, jobTitle: titleTF.text!, location: locationTF.text!, dateApplied: dateTF.text!, status: statusTF.text!)
            destVC?.editCompany(newCompany: newCompany, indexPath: indexPath!)
        }
    }

}
