//
//  SearchResultService.swift
//  JobTrack
//
//  Created by Connor Alvin on 5/12/18.
//  Copyright © 2018 Connor Alvin. All rights reserved.
//

import Foundation

class SearchResult: NSObject, Codable, NSCoding {
    var company: String?
    var title: String?
    var location: String?
    var type: String?
    var companyLogo: String?
    var companyURL: String?
    var url: String?
    
    private enum CodingKeys: String, CodingKey {
        case company = "company"
        case title = "title"
        case location = "location"
        case type = "type"
        case companyLogo = "company_logo"
        case companyURL = "company_url"
        case url = "url"
    }
    init(company: String?, title: String?, location: String?, type: String?, companyLogo: String?, companyURL: String?, url: String?) {
        self.company = company ?? nil
        self.title = title ?? nil
        self.location = location ?? nil
        self.type = type ?? nil
        self.companyLogo = companyLogo ?? nil
        self.companyURL = companyURL ?? nil
        self.url = url ?? nil
    }
    required init?(coder aDecoder: NSCoder) {
        company = aDecoder.decodeObject(forKey: "company") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        location = aDecoder.decodeObject(forKey: "location") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
        companyLogo = aDecoder.decodeObject(forKey: "companyLogo") as? String
        companyURL = aDecoder.decodeObject(forKey: "companyURL") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(company, forKey: "company")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(location, forKey: "location")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(companyLogo, forKey: "companyLogo")
        aCoder.encode(companyURL, forKey: "companyURL")
        aCoder.encode(url, forKey: "url")
    }
}
