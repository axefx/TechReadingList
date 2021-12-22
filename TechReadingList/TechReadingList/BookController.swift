//
//  BookController.swift
//  TechReadingList
//
//  Created by Axel Corro on 12/21/21.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let booksUrl = documentsDir?.appendingPathComponent("ReadingList.plist")
        return booksUrl
    }
}
