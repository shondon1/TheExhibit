//
//  ContentService.swift
//  TheExhibit
//
//  Created by Rashon Hyslop on 3/14/24.
//

import Foundation
import Firebase
import FirebaseFirestore

class ContentService {
    static let shared = ContentService()
    private init() {}

    private var db = Firestore.firestore()

    // Fetch Posts
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        db.collection("posts").order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching posts: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            let posts = documents.compactMap { try? $0.data(as: Post.self) }
            completion(posts)
        }
    }

    // Fetch Notes
    func fetchNotes(completion: @escaping ([Note]) -> Void) {
        db.collection("notes").order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching notes: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            let notes = documents.compactMap { try? $0.data(as: Note.self) }
            completion(notes)
        }
    }
}
