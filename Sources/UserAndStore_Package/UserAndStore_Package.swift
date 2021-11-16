import UIKit

struct UserAndStore_Package {

    public init() {
    }
    
    //MARK:- Create user in firebase and store data to firestore
    func createUserWithDataStore(fcmPushToken : String)
    {
        FireStoreViewModel.shared.storeNewUserDataFirestore(fcmToken: fcmPushToken)
    }
    
    //MARK:- Upload profile pic
    func uploadProfilePicture(image: UIImage, imageName: String, filePath: String)
    {
        FireStoreViewModel.shared.uploadProfilePic(image: image, name: imageName, filePath: filePath)
    }
}
