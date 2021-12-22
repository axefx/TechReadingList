//
//  BookController.swift
//  TechReadingList
//
//  Created by Axel Corro on 12/21/21.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
    }
    func deleteBook(book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books.remove(at: bookIndex)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books[bookIndex].hasBeenRead = !books[bookIndex].hasBeenRead
        saveToPersistentStore()
    }
    
    func updateBook(for book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books[bookIndex].title = book.title
        books[bookIndex].reasonToRead = book.reasonToRead
        saveToPersistentStore()
    }
    
    var readBooks: [Book] {
        return books.filter({ $0.hasBeenRead == true })
    }
    
    var unreadBooks: [Book] {
        return books.filter({ $0.hasBeenRead == false })
    }
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let booksUrl = documentsDir?.appendingPathComponent("ReadingList.plist")
        return booksUrl
    }
    
    func saveToPersistentStore(){
        let encoder = PropertyListEncoder()
        do {
            let booksData = try encoder.encode(books)
            guard let readingListURL = readingListURL else {
                return
            }
            try booksData.write(to: readingListURL)
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let readingListURL = readingListURL else {
                return
            }
            let decoder = PropertyListDecoder()
            let booksData = try Data(contentsOf: readingListURL)
            let books = try decoder.decode([Book].self, from: booksData)
            self.books = books
        } catch {
            print("Error loading: \(error)")
        }
    }
}
