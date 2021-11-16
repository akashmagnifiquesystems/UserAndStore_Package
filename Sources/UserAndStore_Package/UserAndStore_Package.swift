import UIKit
import KRProgressHUD
import Foundation
import Alamofire

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
    
    //MARK:- Get User Personal Info
    public func getPersonalInfo(completion : @escaping (String, String, String, String, String) -> Void)
    {
        let persons = LocalStoreViewModel.shared.readPersonalDetail()
        for p in persons
        {
            completion(p.firstname, p.lastname, p.avtarname, p.email, p.bio)
            break
        }
    }
    
    //MARK:- Get User Address Info
    public func getAddressInfo(completion : @escaping (String, String, String, String, String, String, String, String) -> Void)
    {
        let address = LocalStoreViewModel.shared.readAddress()
        for a in address
        {
            completion(a.firstname, a.lastname, a.addressLine1, a.addressLine2, a.city, a.state, a.zipcode, a.country)
            break
        }
    }

    //MARK:- Update user personal details
    public func updateUserPersonalInfoOnServer(parameters: Parameters, APIName: String, completion: @escaping (NSDictionary) -> Void)
    {
        KRProgressHUD.show()
        ServerCallModel.shared.postUpdateUserData(params: parameters, apiname: APIName) { responseObject in
            KRProgressHUD.dismiss()
            completion(responseObject)
        }
    }
    
    //MARK:-////Store Module/////////////////////////
    
    //MARK:- Insert Store details
    public func insertStoreDetailsToLocalStorage(id:String, storeName:String, storeYourRole:String, storeTxtId:String, storeAddressLine1:String, storeAddressLine2:String, storeCityAddress:String ,storeStateAddress:String, storeZipcodeAddress:String, storeLicenseNumber:String)
    {
        LocalStoreViewModel.shared.insertStoreDetails(id: id, storeName: storeName, storeYourRole: storeYourRole, storeTxtId: storeTxtId, storeAddressLine1: storeAddressLine1, storeAddressLine2: storeAddressLine2, storeCityAddress: storeCityAddress, storeStateAddress: storeStateAddress, storeZipcodeAddress: storeZipcodeAddress, storeLicenseNumber: storeLicenseNumber)
    }
    
    //MARK:- Get Store details
    public func getStoreInfo(completion : @escaping (String, String, String, String, String, String, String, String, String, String) -> Void)
    {
        let storeDetails = LocalStoreViewModel.shared.readStoreDetails()
        for s in storeDetails
        {
            completion(s.autoID, s.storeName, s.storeYourRole, s.storeTxtId, s.storeAddressLine1, s.storeAddressLine2, s.storeCityAddress, s.storeStateAddress, s.storeZipcodeAddress, s.storeLicenseNumber)
            break
        }
    }
    
    //MARK:- Add Product to Local storage
    public func addProductToLocalStorage(id:String, productName:String, productCategory:String, productQTY:String, productCost:String, productDesc:String, productInfo:String ,productImage1:String, productImage2:String, productImage3:String, productImage4:String)
    {
        LocalStoreViewModel.shared.insertInventory(id: id,
                                                   productName: productName,
                                                   productCategory: productCategory,
                                                   productQTY: productQTY,
                                                   productCost: productCost,
                                                   productDesc: productDesc,
                                                   productInfo: productInfo,
                                                   productImage1: productImage1,
                                                   productImage2: productImage2,
                                                   productImage3: productImage3,
                                                   productImage4: productImage4)
    }
    
    //MARK:- Update Product to Local storage
    public func updateProductToLocalStorage(autoId:String, id:String, productName:String, productCategory:String, productQTY:String, productCost:String, productDesc:String, productInfo:String ,productImage1:String, productImage2:String, productImage3:String, productImage4:String)
    {
        LocalStoreViewModel.shared.updateProduct(autoId: autoId,
                                                 id: id,
                                                 productName: productName,
                                                 productCategory: productCategory,
                                                 productQTY: productQTY,
                                                 productCost: productCost,
                                                 productDesc: productDesc,
                                                 productInfo: productInfo,
                                                 productImage1: productImage1,
                                                 productImage2: productImage2,
                                                 productImage3: productImage3,
                                                 productImage4: productImage4)
    }
    
    //MARK:- Delete Product to Local storage
    public func deleteProductFromLocalStorage(id : String)
    {
        LocalStoreViewModel.shared.deleteDetails(queryStatement: "DELETE FROM inventorytable WHERE id = ?;", id: id)
    }
    
    //MARK:- Insert Store details
    public func getInventoryData(searchText: String, completion : @escaping ([InventoryDetails]) -> Void)
    {
        var productListArray : [InventoryDetails] = []

        let prodList = LocalStoreViewModel.shared.readInventory()
        if searchText.count > 0
        {
            for p in prodList
            {
                if p.productName.contains(searchText)
                {
                    productListArray.append(p)
                }
            }
        }else{
            for p in prodList
            {
                productListArray.append(p)
            }
        }
        completion(productListArray)
    }

    //MARK:- Get Product details
    public func getSingleProd(id: String, completion : @escaping (String, String, Int, Int, String, String, String, String, String, String) -> Void)
    {
        let prodDetails = LocalStoreViewModel.shared.readSingleProductInventory(id: id)
        for p in prodDetails
        {
            completion(p.productName, p.productCategory, Int(p.productQTY)!, Int(p.productCost)!, p.productDesc, p.productInfo,p.productImage1, p.productImage2, p.productImage3, p.productImage4)
            break
        }
    }
    
    //MARK:- Update Product Quantity
    public func updateProdQTY(autoId : String, QTY: String)
    {
        LocalStoreViewModel.shared.updateProduct(autoId: autoId,
                                           id: (UserDefaultsStandard.shared.fetchFromDefaults(Key: firestoreUniqueID) as! String),
                                           productQTY: QTY)
    }
}
