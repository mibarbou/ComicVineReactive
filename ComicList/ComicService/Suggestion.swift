//
//  Suggestion.swift
//  ComicList
//
//  Created by Michel Barbou Salvador on 08/10/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation

public struct Suggestion {
    
    public let title: String
}

extension Suggestion: JSONDecodable {
    
    public init?(dictionary: JSONDictionary) {
        guard let title = dictionary["name"] as? String else {
            return nil
        }
        
        self.title = title
    }
}
