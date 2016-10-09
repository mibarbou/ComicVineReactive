//
//  VolumeDescription.swift
//  ComicList
//
//  Created by Michel Barbou Salvador on 09/10/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation


public struct VolumeDescription {
    
    public let description: String?
}

extension VolumeDescription: JSONDecodable {
    
    public init?(dictionary: JSONDictionary) {
        
        guard let stringHtml = dictionary["description"] as? String else {
            
            return nil
        }
        
        description = stringHtml.html2String
        
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    var html2String: String? {
        return html2AttributedString?.string ?? nil
    }
}
