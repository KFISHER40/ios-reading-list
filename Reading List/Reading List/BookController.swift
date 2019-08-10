//
//  BookController.swift
//  Reading List
//
//  Created by Lisa Fisher on 8/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
        
}
    init() {
        loadFromPersistentStore()
    }
    
    @discardableResult func createBook(entitled title: String, withReason reasonToRead: String) -> Book {
        
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func delete(_book: Book) {
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        var hasBeenRead = true
        hasBeenRead = hasBeenRead == false
        
        var readbooks: [Book] {
            let readIt = books.filter {_ in book.hasBeenRead == true}
            return readIt
        }
        
        var unreadBooks: [Book] {
            let notRead = books.filter {_ in book.hasBeenRead == false}
            return notRead
        }
        
        saveToPersistentStore()
    }
    
    func updateTitleAndReason(for book: Book) {
        var title = book.title
        var reasonToRead = book.reasonToRead

            title += ""
            reasonToRead += ""
        
        saveToPersistentStore()
        }
    
    private func saveToPersistentStore() {
    guard let url = readingListURL else { return }
    
    do {
        let encoder = PropertyListEncoder()
        let booksData = try encoder.encode(books)
        try booksData.write(to: url)
    } catch {
        print("Error saving book \(error)")
    }
}
    private func loadFromPersistentStore() {
        
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decodedBooks = PropertyListDecoder()
            books = try decodedBooks.decode([Book].self, from: booksData)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    
    
    
    
}
