import UIKit

public struct UserAndStore_Package {

    public init() {
    }
    //MARK:-////User Module/////////////////////////
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
    
    //MARK:- Insert profile data
    public func insertUserPersonalInfoToLocalStorage(id:String, firstname:String, lastname:String, avtarname:String, email:String, bio:String)
    {
        LocalStoreViewModel.shared.insertPersonalDetail(id: id,
                                                  firstname: firstname,
                                                  lastname: lastname,
                                                  avtarname: avtarname,
                                                  email: email,
                                                  bio: bio)
    }
    
    //MARK:- Insert User Address
    public func insertUserAddressToLocalStorage(id:String, firstname:String, lastname:String, addressLine1:String, addressLine2:String, city:String, state:String, zipcode:String, country:String)
    {
        LocalStoreViewModel.shared.insertAddress(id: id,
                                           firstname: firstname,
                                           lastname: lastname,
                                           addressLine1: addressLine1,
                                           addressLine2: addressLine2,
                                           city: city,
                                           state: state,
                                           zipcode: zipcode,
                                           country: country)
    }
    //MARK:-////Store Module/////////////////////////

}
