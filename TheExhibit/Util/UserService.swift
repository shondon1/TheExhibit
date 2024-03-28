//
//  UserService.swift
//  TheExhibit
//
//  Created by Rashon Hyslop on 3/12/24.
//

import Firebase

struct UserService {
    
    static func fetchUser(uid: String, completion: @escaping(User?) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let snapshot = snapshot, let data = snapshot.data() else {
                print("Error fetching user: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            let user = User(
                id: data["id"] as? String ?? "",
                username: data["username"] as? String ?? "",
                profileImageUrl: data["profileImageUrl"] as? String ?? ""
                // Map other fields if needed
            )
            
            completion(user)
        }
    }
}
