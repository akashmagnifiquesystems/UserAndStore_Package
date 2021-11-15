//
//  User.swift
//  cascade-live
//
//  Created by noda on 8/19/21.
//

import Foundation

struct LiveStreamerKeysInfo {
    var livestreamStreamKey: String
    var livestreamId : String
    var provider : String
    var providerBroadcastBaseUrl : String
    var providerPlaybackBaseUrl : String
    var livestreamPlaybackId : String
}

struct UserStoresInfo {
    var storesManaged : [String]
    var storesOwned : [String]
}

struct User {
    var version : String
    var paymentMethods : [String]
    var isDemoUser : Bool
    var orders : [String]
    var userEmail: String
    var userUUID : String
    var avatarThumbnailFileName : String
    var livestreamerkeysInfo : LiveStreamerKeysInfo
    var userAddresses : [String]
    var avatarName : String
    var userBio : String
    var lastName : String
    var firstName : String
    var registrationStatus : Bool
    var userStoresInfo : UserStoresInfo
    var avatarThumbnailUrl : String
    var userName : String
    var mobileNumber : String
}
