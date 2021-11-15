//
//  UserStore.swift
//  app
//
//  Created by noda on 7/30/21.
//
import Defaults

class UserStore {
    static let shared = UserStore()
    
    func addUser() {
        let user = AppUser()
        Defaults[.user] = user
    }
    
    func verifiedUser(verificationId: String) {
        Defaults[.user].verificationId = verificationId
    }
    
    func verificationId() -> String? {
        return Defaults[.user].verificationId
    }
    
    
    func removeUser() {
        Defaults[.user] = AppUser(verificationId: "", uid: "", email: "", firstName: "", lastName: "", phoneNumber: "")
    }
}
