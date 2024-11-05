//
//  Book.swift
//  Bookworm
//
//  Created by Mój Maczek on 02/11/2024.
//

import Foundation
import SwiftData

@Model // Model works with SwiftData
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date = Date.now // Challenge 3
    var dateFormatted: String {
        date.formatted(date: .abbreviated, time: .shortened)
    }
    
    init(title: String, author: String, genre: String, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }
}
