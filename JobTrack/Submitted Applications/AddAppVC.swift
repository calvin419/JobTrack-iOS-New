//
//  AddAppVC.swift
//  JobTrack
//
//  Created by Connor Alvin on 5/12/18.
//  Copyright © 2018 Connor Alvin. All rights reserved.
//

import UIKit

class AddAppVC: UIViewController {

    @IBOutlet weak var companyTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var statusTF: UITextField!
    
    var appToSubmit: SubmittedApp?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        if appToSubmit != nil {
            companyTF.text = appToSubmit?.company
            titleTF.text = appToSubmit?.jobTitle
            locationTF.text = appToSubmit?.location
            dateTF.text = appToSubmit?.dateApplied
            statusTF.text = appToSubmit?.status
        }
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
        
        if segue.identifier == "unwindFromAdd" {
            let destVC = segue.destination as? ApplicationsList
            let newCompany = SubmittedApp(company: companyTF.text!, jobTitle: titleTF.text!, location: locationTF.text!, dateApplied: dateTF.text!, status: statusTF.text!)
            
            destVC?.addCompany(newCompany: newCompany)
            
        }
    }
}
