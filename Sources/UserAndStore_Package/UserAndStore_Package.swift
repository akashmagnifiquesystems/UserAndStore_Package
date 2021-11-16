import UIKit

public struct UserAndStore_Package {

    public init() {
    }
    
    //MARK:- Create user in firebase and store data to firestore
    public func createUserWithDataStore(fcmPushToken : String, phoneNumber: String)
    {
        UserSetupViewModel.shared.storeNewUserDataFirestore(fcmToken: fcmPushToken, phoneNumber: phoneNumber)
    }
    
    //MARK:- Upload profile pic
    public func uploadProfilePicture(image: UIImage, imageName: String, filePath: String)
    {
        UserSetupViewModel.shared.uploadProfilePic(image: image, name: imageName, filePath: filePath)
    }
}
