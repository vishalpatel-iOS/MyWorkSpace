//
//  PetDetailModel.swift
//  SepiaPets
//
//  Created by codiste on 26/02/23.
//

import Foundation

class PetDetailModel : Codable, Identifiable {
   
    var image_url: String?
    var title: String?
    var content_url: String?
    var date_added: String?
    
    init(fromDictionary dictionary: [String:Any]){
        image_url = dictionary["image_url"] as? String ?? ""
        title = dictionary["title"] as? String ?? ""
        content_url = dictionary["content_url"] as? String ?? ""
        date_added = dictionary["date_added"] as? String ?? ""

    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["image_url"] = image_url
        dictionary["title"] = title
        dictionary["content_url"] = content_url
        dictionary["date_added"] = date_added
        return dictionary
    }
    
    // Blanck details
    internal init(image_url: String? = nil, title: String? = nil, content_url: String? = nil, date_added: String? = nil) {
        self.image_url = image_url
        self.title = title
        self.content_url = content_url
        self.date_added = date_added
    }
}
