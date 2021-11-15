//
//  User.swift
//  cascade-live
//
//  Created by noda on 8/19/21.
//

import Foundation

public struct LiveStreamerKeysInfo {
    public var livestreamStreamKey: String
    public var livestreamId : String
    public var provider : String
    public var providerBroadcastBaseUrl : String
    public var providerPlaybackBaseUrl : String
    public var livestreamPlaybackId : String
}

public struct UserStoresInfo {
    public var storesManaged : [String]
    public var storesOwned : [String]
}

public struct User {
    public var version : String
    public var paymentMethods : [String]
    public var isDemoUser : Bool
    public var orders : [String]
    public var userEmail: String
    public var userUUID : String
    public var avatarThumbnailFileName : String
    public var livestreamerkeysInfo : LiveStreamerKeysInfo
    public var userAddresses : [String]
    public var avatarName : String
    public var userBio : String
    public var lastName : String
    public var firstName : String
    public var registrationStatus : Bool
    public var userStoresInfo : UserStoresInfo
    public var avatarThumbnailUrl : String
    public var userName : String
    public var mobileNumber : String
}
