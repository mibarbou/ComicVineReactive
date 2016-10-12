//
//  Issue.swift
//  ComicList
//
//  Created by Michel Barbou Salvador on 12/10/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation

/// A comic issue
public struct Issue :JSONDecodable {
    
    /// Issue title
    public let title: String?
    
    /// Cover image URL
    public let coverURL: URL?
    
    public init?(dictionary: JSONDictionary) {
        
        guard let title = dictionary["name"] as? String else {
            return nil
        }
        
        self.coverURL = ((dictionary as NSDictionary).value(forKeyPath: "image.small_url") as? String)
            .flatMap { URL(string: $0) }
        
        self.title = title
        
    }
}
