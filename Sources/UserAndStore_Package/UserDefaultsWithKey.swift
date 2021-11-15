//
//  UserDefaultsWithKey.swift
//  cascade-live
//
//  Created by Aakash Patel on 10/09/21.
//

import Foundation
import UIKit
public class UserDefaultsConstants {

    static let shared = UserDefaultsConstants()

    //MARK: Save data to Userdefault
    func saveToUserDefault(value : Any, Key : String)
    {
        UserDefaults.standard.set(value, forKey: Key)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: Save data to Userdefault
    func fetchFromUserDefault(Key : String) -> Any
    {
        return UserDefaults.standard.object(forKey: Key) as Any
    }
}
//Constant keys
let firestoreUniqueID = "firestoreUniqueID"
let failOTPCount = "failOTPCount"
let profilePicURL = "profilePicURL"
let mux_stream_key = "mux_stream_key"
let mux_broadcaster_id = "mux_broadcaster_id"
let mux_playback_id = "mux_playback_id"
let streamLiveUserID = "streamLiveUserID"
let streamLiveUserName = "streamLiveUserName"
let streamLiveUserProfilePic = "streamLiveUserProfilePic"
let streamStoreStreamKey = "streamStoreStreamKey"
let streamStorePublisherID = "streamStorePublisherID"
let mux_stream_key_ForLive = "mux_stream_key_ForLive"
let isTermsAccept = "isTermsAccept"
