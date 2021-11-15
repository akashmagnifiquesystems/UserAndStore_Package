//
//  UserDefaultsWithKey.swift
//  cascade-live
//
//  Created by Aakash Patel on 10/09/21.
//

import Foundation
import UIKit
public class UserDefaultsConstants {

    public static let shared = UserDefaultsConstants()

    //MARK: Save data to Userdefault
    public func saveToUserDefault(value : Any, Key : String)
    {
        UserDefaults.standard.set(value, forKey: Key)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: Save data to Userdefault
    public func fetchFromUserDefault(Key : String) -> Any
    {
        return UserDefaults.standard.object(forKey: Key) as Any
    }
}
//Constant keys
public let firestoreUniqueID = "firestoreUniqueID"
public let failOTPCount = "failOTPCount"
public let profilePicURL = "profilePicURL"
public let mux_stream_key = "mux_stream_key"
public let mux_broadcaster_id = "mux_broadcaster_id"
public let mux_playback_id = "mux_playback_id"
public let streamLiveUserID = "streamLiveUserID"
public let streamLiveUserName = "streamLiveUserName"
public let streamLiveUserProfilePic = "streamLiveUserProfilePic"
public let streamStoreStreamKey = "streamStoreStreamKey"
public let streamStorePublisherID = "streamStorePublisherID"
public let mux_stream_key_ForLive = "mux_stream_key_ForLive"
public let isTermsAccept = "isTermsAccept"
