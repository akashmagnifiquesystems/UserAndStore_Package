//
//  File.swift
//  
//
//  Created by Aakash Patel on 16/11/21.
//

import Foundation

public class UserDefaultsStandard {
    
    static let shared = UserDefaultsStandard()

    //MARK: Save data to Userdefault
    func saveToDefaults(value : Any, Key : String)
    {
        UserDefaults.standard.set(value, forKey: Key)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: Save data to Userdefault
    func fetchFromDefaults(Key : String) -> Any
    {
        return UserDefaults.standard.object(forKey: Key) as Any
    }

}
//Constant keys
let firestoreUniqueID = "firestoreUniqueID"
let profilePicURL = "profilePicURL"
