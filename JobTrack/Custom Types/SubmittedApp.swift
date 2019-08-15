//
//  SubmittedApp.swift
//  JobTrack
//
//  Created by Connor Alvin on 5/12/18.
//  Copyright © 2018 Connor Alvin. All rights reserved.
//

import Foundation

class SubmittedApp: NSObject, NSCoding {
    var company: String
    var jobTitle: String
    var location: String
    var dateApplied: String
    var status: String
    
    init(company: String, jobTitle: String, location: String, dateApplied: String, status: String) {
        self.company = company
        self.jobTitle = jobTitle
        self.location = location
        self.dateApplied = dateApplied
        self.status = status
    }
    required init?(coder aDecoder: NSCoder) {
        company = aDecoder.decodeObject(forKey: "company") as! String
        jobTitle = aDecoder.decodeObject(forKey: "jobTitle") as! String
        location = aDecoder.decodeObject(forKey: "location") as! String
        dateApplied = aDecoder.decodeObject(forKey: "dateApplied") as! String
        status = aDecoder.decodeObject(forKey: "status") as! String
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(company, forKey: "company")
        aCoder.encode(jobTitle, forKey: "jobTitle")
        aCoder.encode(location, forKey: "location")
        aCoder.encode(dateApplied, forKey: "dateApplied")
        aCoder.encode(status, forKey: "status")
    }
}
