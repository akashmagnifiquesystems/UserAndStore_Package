//
//  FireStoreViewModel.swift
//  cascade-live
//
//  Created by Aakash Patel on 09/09/21.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage
import UIKit

public class FireStoreViewModel {
    let id = UUID()
    let db = Firestore.firestore()
    
    public var userDefaults = UserDefaultsConstants()
    public var phoneNumber : String?
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    public init() {
        
    }
    
    func storeNewUserDataFirestore() {
        var ref: DocumentReference? = nil
        ref = self.db.collection("user").addDocument(data: [
            "app_version": appVersion ?? "",
            "avatar_image_url": "",
            "avatar_name": "",
            "bio": "",
            "device_details": self.modelIdentifier(),
            "device_type": "iphone",
            "email": "",
            "first_name": "",
            "last_name": "",
//            "notification_token": AppDelegate.shared.fcmPushToken ?? "",
            "phone_no": phoneNumber ?? "",
            
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.userDefaults.saveToUserDefault(value: ref!.documentID, Key: firestoreUniqueID)
            }
        }
    }
    
    func modelIdentifier() -> String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
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
                self.userDefaults.saveToUserDefault(value: url!.absoluteString, Key: profilePicURL)
//                NotificationCenter.default.post(name: NSNotification.profileUpdate,
//                                                object: nil, userInfo: nil)
            })
        }
    }
    
}
