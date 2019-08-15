//
//  AddFutAppVC.swift
//  JobTrack
//
//  Created by Connor Alvin on 5/27/18.
//  Copyright © 2018 Connor Alvin. All rights reserved.
//

import UIKit

class AddFutAppVC: UIViewController {

    @IBOutlet weak var companyTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var typeTF: UITextField!

    
    var passedFutApp: SearchResult?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        if passedFutApp != nil {
            companyTF.text = passedFutApp?.company
            titleTF.text = passedFutApp?.title
            locationTF.text = passedFutApp?.location
            typeTF.text = passedFutApp?.type
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
        if segue.identifier == "unwindFromAddFut" {
            let destVC = segue.destination as? ToApplyList
            let newCompany = SearchResult(company: companyTF.text!, title: titleTF.text!, location: locationTF.text, type: typeTF.text, companyLogo: nil, companyURL: nil, url: nil)
            
            destVC?.addCompany(newCompany: newCompany)
        }
    }

}
