//
//  Book.swift
//  TechReadingList
//
//  Created by Axel Corro on 12/20/21.
//

import Foundation

struct Book: Codable, Equatable {
    let title: String
    let reasonToRead: String
    let hasBeenRead: Bool
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
}
