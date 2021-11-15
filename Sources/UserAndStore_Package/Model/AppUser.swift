//
//  User.swift
//  app
//
//  Created by noda on 7/24/21.
//

import Defaults

public struct AppUser : Codable, Defaults.Serializable {
    public static let idKey = \AppUser.verificationId
    public var verificationId : String?
    public var uid: String?
    public var email: String?
    public var firstName: String?
    public var lastName: String?
    public var phoneNumber : String?
}

extension Defaults.Keys {
    static let user = Key<AppUser>("user", default: .init(verificationId: "", uid: "", email: "", firstName: "", lastName: "", phoneNumber: ""))
}
