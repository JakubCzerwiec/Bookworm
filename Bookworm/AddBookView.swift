//
//  AddBookView.swift
//  Bookworm
//
//  Created by Mój Maczek on 02/11/2024.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext // is like a link to book class, so we can read and write new books into the memory
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    var hasValidForm: Bool { // Challenge 1 - validating the form
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || review.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook) // adding new book to memory
                        dismiss()
                    }
                }
                .disabled(hasValidForm == false)
            }
            .navigationTitle("Add Book")
            
        }
    }
}

#Preview {
    AddBookView()
}
