//
//  DatabaseManager.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/18/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private var db = Firestore.firestore()
    var user: User?
    private var userReference: DocumentReference?
    
    //    public func checkIfUserTokenExists(token: String) -> DocumentReference {
    //        return db.collection("users").document(token)
    //    }
    
    public func addUserInfo(user: User) {
        do {
            let newUserReference = try db.collection("users").addDocument(from: user)
            self.userReference = newUserReference
            print("Added \(user.displayName) to the database with reference \(newUserReference)")
        } catch {
            fatalError("Could not add user to database")
        }
    }
    
    public func fetchUserInfo(userDocumentReference: DocumentReference) -> User? {
        print(userDocumentReference.path)
        
        userDocumentReference.getDocument(as: User.self) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let failure):
                fatalError(failure.localizedDescription)
            }
        }
        
        return user
    }
    
    public func doesUserExist(user: User) {
        
        db.collection("users").whereField("token", isEqualTo: user.token).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let count = querySnapshot!.documents.count
                print("found \(count) accounts with token \(user)")
                
                if count == 0 {
                    self.addUserInfo(user: user)
                } else {
                    let userDict = querySnapshot!.documents.first?.data()
                    let user = User(data: userDict!)
                    print(querySnapshot!.documents.first?.documentID)
                    self.user = user
                }
            }
        }
    }
    
    // TODO: Refactor next two funcs
    public func updateCountry(country: String) {
        do {
            self.db.collection("users").document(self.userReference!.documentID).getDocument() { snapshot, error in
                if let error = error {
                    print("Error finding user: \(error)")
                } else {
                    snapshot?.reference.updateData([
                        "country": country
                    ])
                    print("Successfully updated country to \(country)")
                }
            }
        } catch {
            fatalError("Could not add user to database")
        }
    }
    
    public func updateBirthdate(birthdate: Date) {
        do {
            self.db.collection("users").document(self.userReference!.documentID).getDocument() { snapshot, error in
                if let error = error {
                    print("Error finding user: \(error)")
                } else {
                    snapshot?.reference.updateData([
                        "birthdate": birthdate
                    ])
                    print("Successfully updated birthdate to \(birthdate)")
                }
            }
        } catch {
            fatalError("Could not add user to database")
        }
    }
    
    func fetchAllUsers(completion: @escaping([User]) -> Void) {
            var users = [User]()
            
            Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
                snapshot?.documents.forEach({ (document) in
                    let dictionary = document.data()
                    let user = User(data: dictionary)
                    users.append(user)
                    
                    if users.count == snapshot?.documents.count {
                        completion(users)
                    }
                })
            }
        }
}


// MARK: Populate fake dummy accounts
extension DatabaseManager {
    public func addFakeUsersToDB(users: [User]) {
        for user in users {
            do {
                try db.collection("users").addDocument(from: user)
                print("Added \(user.displayName) to the database")
            } catch {
                fatalError("Could not add user \(user.displayName) to database")
            }
        }
        
    }
}


//let fakeUser1 = User(displayName: "User1", bitmojiURL: URL(string: "https://www.pngkit.com/png/detail/539-5397650_bitmoji-pinterest-png-dab-emoji-bitstrips-background-bitstrips.png")!, token: "token1")
//let fakeUser2 = User(displayName: "User2", bitmojiURL: URL(string: "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/2b65ca6a-2e94-4b14-b8b3-fc4fc3ffa328/daoc64d-4fb367a7-325e-41c4-9099-dce58802d0e3.png/v1/fill/w_396,h_398,strp/my_bitstrips_avatar_bitmoji_style__by_isaiahcontrerasage08_daoc64d-fullview.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9Mzk4IiwicGF0aCI6IlwvZlwvMmI2NWNhNmEtMmU5NC00YjE0LWI4YjMtZmM0ZmMzZmZhMzI4XC9kYW9jNjRkLTRmYjM2N2E3LTMyNWUtNDFjNC05MDk5LWRjZTU4ODAyZDBlMy5wbmciLCJ3aWR0aCI6Ijw9Mzk2In1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.WlUKFbAFCUg97h8VSvOogaflSu_m1P5lH0hkYqPWtug")!, token: "token2")
//let fakeUser3 = User(displayName: "User3", bitmojiURL: URL(string: "https://camo.githubusercontent.com/557c3dd0aefb4283a8d684ee8f460c98c8c907d9c94594a93a629a20b9f93a9b/68747470733a2f2f707265766965772e6269746d6f6a692e636f6d2f6176617461722d6275696c6465722d76332f707265766965772f686561643f7363616c653d332667656e6465723d31267374796c653d3526726f746174696f6e3d302662656172643d323231322662726f773d3135353526636865656b5f64657461696c733d31333536266561723d31343233266579653d31363134266579656c6173683d2d31266579655f64657461696c733d3133353226666163655f6c696e65733d3133363626676c61737365733d3234363526686169723d31373233266861743d32343935266a61773d31343030266d6f7574683d32333338266e6f73653d313438322662656172645f746f6e653d3836373832303826626c7573685f746f6e653d31363735343038382662726f775f746f6e653d3637373230393026657965736861646f775f746f6e653d2d3126686169725f746f6e653d3836333735353026686169725f74726561746d656e745f746f6e653d3130353133393435266c6970737469636b5f746f6e653d313637343036363826707570696c5f746f6e653d3537393333383526736b696e5f746f6e653d3936353736353526626f64793d3126666163655f70726f706f7274696f6e3d3133266579655f73706163696e673d30266579655f73697a653d32266f75746669743d393930343931")!, token: "token3")
//let fakeUser4 = User(displayName: "User4", bitmojiURL: URL(string: "https://sdk.bitmoji.com/render/panel/2e85858e-0458-4503-88d9-ce0fc1c72205-1Gytk5clhHCxmwj1oNxzw9zKK~ciYkOfidUJ1Pj7MU4wUxpmaHg_iw-v1.png?transparent=1&palette=1")!, token: "token4")
//let fakeUser5 = User(displayName: "User5", bitmojiURL: URL(string: "https://pbs.twimg.com/media/CZHHNQjWEAAJvxe.png")!, token: "token5")
//let fakeUser6 = User(displayName: "User6", bitmojiURL: URL(string: "https://blog.tcea.org/wp-content/uploads/2020/12/happyface_noneck.png")!, token: "token6")
//let fakeUser7 = User(displayName: "User7", bitmojiURL: URL(string: "https://s.pngkit.com/png/small/322-3225019_2996-bitmoji-boy.png")!, token: "token7")
//
//let fakeUsers = [fakeUser1, fakeUser2, fakeUser3, fakeUser4, fakeUser5, fakeUser6, fakeUser7]
//
//DatabaseManager.shared.addFakeUsersToDB(users: fakeUsers)
