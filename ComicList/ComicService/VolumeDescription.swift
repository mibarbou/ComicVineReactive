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
        description = dictionary["description"] as? String
    }
}
