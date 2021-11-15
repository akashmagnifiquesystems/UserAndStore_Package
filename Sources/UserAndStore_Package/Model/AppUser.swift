//
//  User.swift
//  app
//
//  Created by noda on 7/24/21.
//

import Defaults

struct AppUser : Codable, Defaults.Serializable {
    static let idKey = \AppUser.verificationId
    var verificationId : String?
    var uid: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var phoneNumber : String?
}

extension Defaults.Keys {
    static let user = Key<AppUser>("user", default: .init(verificationId: "", uid: "", email: "", firstName: "", lastName: "", phoneNumber: ""))
}
