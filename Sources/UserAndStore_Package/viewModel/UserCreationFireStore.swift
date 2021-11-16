//
//  File.swift
//  
//
//  Created by Aakash Patel on 16/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage
import UIKit


public class UserCreationFireStore {
    
    static let shared = FireStoreViewModel()
    
    let id = UUID()
    let db = Firestore.firestore()
    
    public var userDefaults = UserDefaultsStandard()
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    init() {
        
    }
    
    func storeNewUserDataFirestore(fcmToken: String, phoneNumber: String) {
        var ref: DocumentReference? = nil
        ref = self.db.collection("user").addDocument(data: [
            "app_version": appVersion ?? "",
            "avatar_image_url": "",
            "avatar_name": "",
            "bio": "",
            "device_details": Utility.shared.modelIdentifier(),
            "device_type": "iphone",
            "email": "",
            "first_name": "",
            "last_name": "",
            "notification_token": fcmToken,
            "phone_no": phoneNumber,
            
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.userDefaults.saveToDefaults(value: ref!.documentID, Key: firestoreUniqueID)
            }
        }
    }
    
    
    func uploadProfilePic(image: UIImage, name: String, filePath: String) {
        guard let imageData: Data = image.jpegData(compressionQuality: 0.1) else {
            return
        }
        
        let metaDataConfig = StorageMetadata()
        metaDataConfig.contentType = "image/jpg"
        
        let storageRef = Storage.storage().reference(withPath: "\(filePath)/\(name)")
        
        storageRef.putData(imageData, metadata: metaDataConfig){ (metaData, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            storageRef.downloadURL(completion: { (url: URL?, error: Error?) in
                print(url?.absoluteString ?? "") // <- Download URL
                self.userDefaults.saveToDefaults(value: url!.absoluteString, Key: profilePicURL)
                NotificationCenter.default.post(name: NSNotification.profileUpdate,
                                                object: nil, userInfo: nil)
            })
        }
    }
    
}
extension NSNotification {
    public static let profileUpdate = Notification.Name.init("profileUpdate")
    public static let inventoryUpdate = Notification.Name.init("inventoryUpdate")
    public static let scheduleInstanStream = Notification.Name.init("scheduleInstanStream")
    
}

