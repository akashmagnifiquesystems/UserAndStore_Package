//
//  UserStore.swift
//  app
//
//  Created by noda on 7/30/21.
//
import Defaults

public class UserStore {
    public static let shared = UserStore()
    
    public func addUser() {
        let user = AppUser()
        Defaults[.user] = user
    }
    
    public func verifiedUser(verificationId: String) {
        Defaults[.user].verificationId = verificationId
    }
    
    public func verificationId() -> String? {
        return Defaults[.user].verificationId
    }
    
    
    public func removeUser() {
        Defaults[.user] = AppUser(verificationId: "", uid: "", email: "", firstName: "", lastName: "", phoneNumber: "")
    }
}
