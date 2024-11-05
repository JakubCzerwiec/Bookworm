//
//  ContentView.swift
//  Bookworm
//
//  Created by Mój Maczek on 02/11/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext // is like a link to book class, so we can read and write new books into the memory
    @Query(sort: [ // sorting first by title, if title same, sorting by author
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book] // @Query observes and updates books whenever there is a change
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating < 2 ? .red : .black) // Challange 2
                                
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
