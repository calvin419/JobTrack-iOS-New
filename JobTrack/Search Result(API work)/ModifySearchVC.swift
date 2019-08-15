//
//  ModifySearchVC.swift
//  JobTrack
//
//  Created by Connor Alvin on 5/12/18.
//  Copyright © 2018 Connor Alvin. All rights reserved.
//

import UIKit

class ModifySearchVC: UIViewController {

    @IBOutlet weak var descripTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var typeSwitch: UISwitch!
    
    var newApiString: String = ""
    var oldDescrip: String?
    var oldLocation: String?
    var oldType: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        if oldDescrip != nil {
            descripTF.text = oldDescrip
        }
        if oldLocation != nil {
            locationTF.text = oldLocation
        }
        if !oldType && typeSwitch.isOn {
            typeSwitch.setOn(false, animated: false)
        } else if oldType && !typeSwitch.isOn {
            typeSwitch.setOn(true, animated: false)
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
        if segue.identifier == "unwindFromApply" {
            let destVC = segue.destination as? SearchResultsList
            var descripString: String?
            var locationString: String?
            destVC?.descrips = ""
            destVC?.location = ""
            if descripTF.text != "" {
                descripString = "description=" + (descripTF?.text?.replacingOccurrences(of: " ", with: "+"))! + "&"
                newApiString += descripString!
                destVC?.descrips = descripString!
            }
            if locationTF.text != "" {
                locationString = "location=" + (locationTF?.text?.replacingOccurrences(of: " ", with: "+"))! + "&"
                newApiString += locationString!
                destVC?.location = locationString!
            }
            if(typeSwitch.isOn) {
                newApiString += "full_time=on"
                destVC?.type = true
            } else {
                destVC?.type = false
            }
            destVC?.apiString = newApiString
        }
    }

}
