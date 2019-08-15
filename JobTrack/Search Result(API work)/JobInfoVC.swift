//
//  JobInfoVC.swift
//  JobTrack
//
//  Created by Connor Alvin on 5/12/18.
//  Copyright © 2018 Connor Alvin. All rights reserved.
//

import UIKit

class JobInfoVC: UIViewController {

    var jobURL: String?
    var iconURL: String?
    var companyURL: String?
    var company: String?
    var jobTitle: String?
    var location: String?
    var type: String?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var jobSiteButton: UIButton!
    @IBAction func loadCompanyURL(_ sender: UIButton) {
        let compURL = URL(string: companyURL!)
        
        if UIApplication.shared.canOpenURL(compURL!) {
            UIApplication.shared.open(compURL!, options: [:], completionHandler: nil)
        }
    }
    @IBAction func loadURL(_ sender: UIButton) {
        let gitURL = URL(string: jobURL!)
        
        if UIApplication.shared.canOpenURL(gitURL!) {
            UIApplication.shared.open(gitURL!, options: [:], completionHandler: nil)
        }
    }
    @IBAction func addAppToList(_ sender: UIButton) {
        performSegue(withIdentifier: "addAppToList", sender: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if companyURL == nil {
            jobSiteButton.isHidden = true
        }
        if iconURL != nil {
            DispatchQueue.global(qos: .userInitiated).async {
                let url = URL(string: self.iconURL!)
                let responseData = try? Data(contentsOf: url!)
                let downloadedImage = UIImage(data: responseData!)
                DispatchQueue.main.async {
                    self.image.image = downloadedImage
                }
            }
        } else {
            self.image.image = #imageLiteral(resourceName: "image-not-found")
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
        if segue.identifier == "addAppToList" {
            let destVC = segue.destination as? AddFutAppVC
            destVC?.passedFutApp = SearchResult(company: company!, title: jobTitle!, location: location!, type: type!, companyLogo: nil, companyURL: nil, url: nil)
        }
    }

}
