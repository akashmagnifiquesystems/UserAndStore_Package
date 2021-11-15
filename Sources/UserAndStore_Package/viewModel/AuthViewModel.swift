//
//  AuthViewModel.swift
//  app
//
//  Created by noda on 7/24/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

public struct AuthStatus {
    var isLoggedIn = false
    var isReceivedCode = false
    var isVerifySuccess = false
    var isSignedOut = false
    var isLoading = false
    var isError = false
    var error = ""
}

public class AuthViewModel {
    let id = UUID()
    
    public var status = AuthStatus()
    
    public var phoneNumber = ""
    public var countryCode = "+1"
    
    public var verificationCode = ""
    
    public var fireStoreViewModel = FireStoreViewModel()
    
    public var userDefaultsViewModel = UserDefaultsConstants()
    
    public init() {
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            self.countryCode = "+" + Constants.countryDictionary[countryCode]!
        }
    }
    
    public func verify() {
//        UIApplication.shared.endEditing()
        if self.phoneNumber.count == 0
        {
            self.status.isError = true
            self.status.error = "Enter Phone Number"
            return
        }
        let phoneNumber = "\(self.countryCode)\(self.phoneNumber)"
        self.status.isReceivedCode = false
        self.status.isLoading = true
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationId, error in
                self.status.isLoading = false
                UserStore.shared.addUser()
                if let error = error {
                    self.status.error = error.localizedDescription
                    self.status.isError = true
                } else {
                    self.status.isReceivedCode = true
                    self.status.isError = false
                    UserStore.shared.verifiedUser(verificationId: verificationId!)
                    self.userDefaultsViewModel.saveToUserDefault(value: 0, Key: failOTPCount)
                }
            }
    }
    
    public func signIn() {
//        UIApplication.shared.endEditing()
        if self.status.isReceivedCode && verificationCode.count != 0 {
            if let verificationId = UserStore.shared.verificationId() {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: verificationCode)
                self.status.isLoading = true
                Auth.auth().signIn(with: credential) { authData, error in
                    self.status.isLoading = false
                    if let err = error {
                        self.status.error = err.localizedDescription
                        self.status.isError = true
                        var OTPCount = (self.userDefaultsViewModel.fetchFromUserDefault(Key: failOTPCount) as! Int)
                        if OTPCount != 2
                        {
                            OTPCount = OTPCount + 1
                            self.userDefaultsViewModel.saveToUserDefault(value: OTPCount, Key: failOTPCount)
                        }else{
                            self.status.isReceivedCode = false
                            self.userDefaultsViewModel.saveToUserDefault(value: 0, Key: failOTPCount)
                        }
                    } else {
                        self.userDefaultsViewModel.saveToUserDefault(value: 0, Key: failOTPCount)
                        self.status.isReceivedCode = false
                        self.status.isVerifySuccess = true
                        self.status.isSignedOut = false
                        self.status.isError = false
                        self.fireStoreViewModel.phoneNumber = (authData?.user.phoneNumber)
                        self.fireStoreViewModel.storeNewUserDataFirestore()
                    }
                }
            }
        }
    }
    
    public func signOut() {
        UserStore.shared.removeUser()
        do {
            try Auth.auth().signOut()
            self.status.isSignedOut = true
        }catch let signOutError as NSError {
            self.status.isError = true
            self.status.error = signOutError.localizedDescription
        }
    }
}
