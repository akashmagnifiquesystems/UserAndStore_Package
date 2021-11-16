//
//  File.swift
//  
//
//  Created by Aakash Patel on 16/11/21.
//

import Foundation
import SQLite3

public class Person
{
    
    public var id: String = ""
    public var firstname: String = ""
    public var lastname: String = ""
    public var avtarname: String = ""
    public var email: String = ""
    public var bio: String = ""
    
    init(id:String, firstname:String, lastname:String, avtarname:String, email:String, bio:String)
    {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.avtarname = avtarname
        self.email = email
        self.bio = bio
    }
    
}
public class PersonAddress
{
    
    public var id: String = ""
    public var firstname: String = ""
    public var lastname: String = ""
    public var addressLine1: String = ""
    public var addressLine2: String = ""
    public var city: String = ""
    public var state: String = ""
    public var zipcode: String = ""
    public var country: String = ""
    
    init(id:String, firstname:String, lastname:String, addressLine1:String, addressLine2:String, city:String, state:String, zipcode:String, country:String)
    {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.state = state
        self.zipcode = zipcode
        self.country = country
    }
    
}
public class StoreDetails
{
    public var autoID: String = ""
    public var id: String = ""
    public var storeName : String = ""
    public var storeYourRole : String = ""
    public var storeTxtId : String = ""
    public var storeAddressLine1 : String = ""
    public var storeAddressLine2 : String = ""
    public var storeCityAddress : String = ""
    public var storeStateAddress : String = ""
    public var storeZipcodeAddress : String = ""
    public var storeLicenseNumber : String = ""
    
    init(autoID:String, id:String, storeName:String, storeYourRole:String, storeTxtId:String, storeAddressLine1:String, storeAddressLine2:String, storeCityAddress:String ,storeStateAddress:String, storeZipcodeAddress:String, storeLicenseNumber:String)
    {
        self.autoID = autoID
        self.id = id
        self.storeName = storeName
        self.storeYourRole = storeYourRole
        self.storeTxtId = storeTxtId
        self.storeAddressLine1 = storeAddressLine1
        self.storeAddressLine2 = storeAddressLine2
        self.storeCityAddress = storeCityAddress
        self.storeStateAddress = storeStateAddress
        self.storeZipcodeAddress = storeZipcodeAddress
        self.storeLicenseNumber = storeLicenseNumber
    }
    
}
public class InventoryDetails
{
    public var autoID: String = ""
    public var id: String = ""
    public var productName : String = ""
    public var productCategory : String = ""
    public var productQTY : String = ""
    public var productCost : String = ""
    public var productDesc : String = ""
    public var productInfo : String = ""
    public var productImage1 : String = ""
    public var productImage2 : String = ""
    public var productImage3 : String = ""
    public var productImage4 : String = ""
    
    init(autoID: String, id:String, productName:String, productCategory:String, productQTY:String, productCost:String, productDesc:String, productInfo:String ,productImage1:String, productImage2:String, productImage3:String, productImage4:String)
    {
        self.autoID = autoID
        self.id = id
        self.productName = productName
        self.productCategory = productCategory
        self.productQTY = productQTY
        self.productCost = productCost
        self.productDesc = productDesc
        self.productInfo = productInfo
        self.productImage1 = productImage1
        self.productImage2 = productImage2
        self.productImage3 = productImage3
        self.productImage4 = productImage4
    }
}
public class LocalStoreViewModel {
    
    static let shared = LocalStoreViewModel()
    
    public init()
    {
        db = openDatabase()
        createPersonalDetailTable()
        createTableforAddress()
        createTableforStoreDetails()
        createTableforInventory()
    }
    
    public let dbPath: String = "cascadeDB.sqlite"
    public var db:OpaquePointer?
    
    public func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            return nil
        }
        else
        {
            return db
        }
    }
    
    public func createPersonalDetailTable() {
        let createTableString = "create table if not exists person (id INTEGER PRIMARY KEY AUTOINCREMENT, uniqueID TEXT, first_name TEXT, last_name TEXT, avtar_name TEXT, email TEXT, bio TEXT)"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
            } else {
            }
        } else {
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    public func insertPersonalDetail(id:String, firstname:String, lastname:String, avtarname:String, email:String, bio:String)
    {
        let persons = readPersonalDetail()
        for p in persons
        {
            if p.id == id
            {
                self.deleteDetails(queryStatement: "DELETE FROM person WHERE uniqueID = ?;", id: id)
            }
        }
        let insertStatementString = "INSERT INTO person (uniqueID, first_name, last_name, avtar_name, email, bio) VALUES (?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (firstname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (lastname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (avtarname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (bio as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                //                print("Successfully inserted row.")
            } else {
                //                print("Could not insert row.")
            }
        } else {
            //            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    public func readPersonalDetail() -> [Person] {
        let queryStatementString = "SELECT * FROM person WHERE uniqueID = ?;"
        var queryStatement: OpaquePointer? = nil
        var psns : [Person] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (UserDefaultsStandard.shared.fetchFromDefaults(Key: firestoreUniqueID) as! String), -1, nil)
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let firstname = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let lastname = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let avtarname = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let bio = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                
                psns.append(Person(id: id, firstname: firstname, lastname: lastname, avtarname: avtarname, email: email, bio: bio))
            }
        } else {
            //            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    public func createTableforAddress() {
        let createTableString = "create table if not exists useraddress (id INTEGER PRIMARY KEY AUTOINCREMENT, uniqueID TEXT, first_name TEXT, last_name TEXT, addressline1 TEXT, addressline2 TEXT, city TEXT, state TEXT, zipcode TEXT, country TEXT)"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                //                print("person table created.")
            } else {
                //                print("person table could not be created.")
            }
        } else {
            //            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    public func insertAddress(id:String, firstname:String, lastname:String, addressLine1:String, addressLine2:String, city:String, state:String, zipcode:String, country:String)
    {
        let persons = readAddress()
        for p in persons
        {
            if p.id == id
            {
                self.deleteDetails(queryStatement: "DELETE FROM useraddress WHERE uniqueID = ?;", id: id)
            }
        }
        let insertStatementString = "INSERT INTO useraddress (uniqueID, first_name, last_name, addressline1, addressline2, city, state, zipcode, country) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (firstname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (lastname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (addressLine1 as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (addressLine2 as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (city as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (state as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (zipcode as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (country as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                //                print("Successfully inserted row.")
            } else {
                //                print("Could not insert row.")
            }
        } else {
            //            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    public func readAddress() -> [PersonAddress] {
        let queryStatementString = "SELECT * FROM useraddress WHERE uniqueID = ?;"
        var queryStatement: OpaquePointer? = nil
        var psns : [PersonAddress] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (UserDefaultsStandard.shared.fetchFromDefaults(Key: firestoreUniqueID) as! String), -1, nil)
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let firstname = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let lastname = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let addressLine1 = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let addressLine2 = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let city = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let state = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let zipcode = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let country = String(describing: String(cString: sqlite3_column_text(queryStatement, 9)))
                
                psns.append(PersonAddress(id: id, firstname: firstname, lastname: lastname, addressLine1: addressLine1, addressLine2: addressLine2, city: city, state: state, zipcode: zipcode, country: country))
                //                print("Query Result:")
                //                print("\(id) | \(firstname) | \(lastname)")
            }
        } else {
            //            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
   
    public func createTableforStoreDetails() {
        let createTableString = "create table if not exists storedetailstable (id INTEGER PRIMARY KEY AUTOINCREMENT, uniqueID TEXT, store_name TEXT, store_role TEXT, store_txtid TEXT, store_address1 TEXT, store_address2 TEXT, store_city TEXT, store_state TEXT, store_zipcode TEXT, store_licensenumber TEXT)"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                //                print("person table created.")
            } else {
                //                print("person table could not be created.")
            }
        } else {
            //            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    public func insertStoreDetails(id:String, storeName:String, storeYourRole:String, storeTxtId:String, storeAddressLine1:String, storeAddressLine2:String, storeCityAddress:String ,storeStateAddress:String, storeZipcodeAddress:String, storeLicenseNumber:String)
    {
        let persons = readStoreDetails()
        for p in persons
        {
            if p.id == id
            {
                self.deleteDetails(queryStatement: "DELETE FROM storedetailstable WHERE uniqueID = ?;", id: id)
            }
        }
        let insertStatementString = "INSERT INTO storedetailstable (uniqueID, store_name, store_role, store_txtid, store_address1, store_address2, store_city, store_state, store_zipcode, store_licensenumber) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (storeName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (storeYourRole as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (storeTxtId as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (storeAddressLine1 as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (storeAddressLine2 as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (storeCityAddress as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (storeStateAddress as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (storeZipcodeAddress as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 10, (storeLicenseNumber as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                //                print("Successfully inserted row.")
            } else {
                //                print("Could not insert row.")
            }
        } else {
            //            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    public func readStoreDetails() -> [StoreDetails] {
        let queryStatementString = "SELECT * FROM storedetailstable WHERE uniqueID = ?;"
        var queryStatement: OpaquePointer? = nil
        var psns : [StoreDetails] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (UserDefaultsStandard.shared.fetchFromDefaults(Key: firestoreUniqueID) as! String), -1, nil)
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let autoID = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let storeName = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let storeYourRole = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let storeTxtId = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let storeAddressLine1 = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let storeAddressLine2 = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let storeCityAddress = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let storeStateAddress = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let storeZipcodeAddress = String(describing: String(cString: sqlite3_column_text(queryStatement, 9)))
                let storeLicenseNumber = String(describing: String(cString: sqlite3_column_text(queryStatement, 10)))
                
                psns.append(StoreDetails(autoID: autoID, id: id, storeName: storeName, storeYourRole: storeYourRole, storeTxtId: storeTxtId, storeAddressLine1: storeAddressLine1, storeAddressLine2: storeAddressLine2, storeCityAddress: storeCityAddress, storeStateAddress: storeStateAddress, storeZipcodeAddress: storeZipcodeAddress, storeLicenseNumber: storeLicenseNumber))
            }
        } else {
            //            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    public func createTableforInventory() {
        let createTableString = "create table if not exists inventorytable (id INTEGER PRIMARY KEY AUTOINCREMENT, uniqueID TEXT, product_name TEXT, product_category TEXT, product_qty TEXT, product_cost TEXT, product_desc TEXT, product_info TEXT, product_image1 TEXT, product_image2 TEXT, product_image3 TEXT, product_image4 TEXT)"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                //                                print("person table created.")
            } else {
                //                                print("person table could not be created.")
            }
        } else {
//            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    public func insertInventory(id:String, productName:String, productCategory:String, productQTY:String, productCost:String, productDesc:String, productInfo:String ,productImage1:String, productImage2:String, productImage3:String, productImage4:String)
    {
        let insertStatementString = "INSERT INTO inventorytable (uniqueID, product_name, product_category, product_qty, product_cost, product_desc, product_info, product_image1, product_image2, product_image3, product_image4) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (productName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (productCategory as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (productQTY as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (productCost as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (productDesc as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (productInfo as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (productImage1 as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (productImage2 as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 10, (productImage3 as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 11, (productImage4 as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                //                print("Successfully inserted row.")
            } else {
                //                print("Could not insert row.")
            }
        } else {
            //            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    public func readInventory() -> [InventoryDetails] {
        let queryStatementString = "SELECT * FROM inventorytable WHERE uniqueID = ?;"
        var queryStatement: OpaquePointer? = nil
        var psns : [InventoryDetails] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (UserDefaultsStandard.shared.fetchFromDefaults(Key: firestoreUniqueID) as! String), -1, nil)
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let autoID = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let productName = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let productCategory = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let productQTY = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let productCost = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let productDesc = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let productInfo = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let productImage1 = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let productImage2 = String(describing: String(cString: sqlite3_column_text(queryStatement, 9)))
                let productImage3 = String(describing: String(cString: sqlite3_column_text(queryStatement, 10)))
                let productImage4 = String(describing: String(cString: sqlite3_column_text(queryStatement, 11)))
                
                psns.append(InventoryDetails(autoID: autoID, id:id, productName:productName, productCategory:productCategory, productQTY:productQTY, productCost:productCost, productDesc:productDesc, productInfo:productInfo ,productImage1:productImage1, productImage2:productImage2, productImage3:productImage3, productImage4:productImage4))
            }
        } else {
            //            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    public func readSingleProductInventory(id:String) -> [InventoryDetails] {
        let queryStatementString = "SELECT * FROM inventorytable WHERE id = ?;"
        var queryStatement: OpaquePointer? = nil
        var psns : [InventoryDetails] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, id, -1, nil)
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let autoID = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let productName = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let productCategory = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let productQTY = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let productCost = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let productDesc = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let productInfo = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let productImage1 = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let productImage2 = String(describing: String(cString: sqlite3_column_text(queryStatement, 9)))
                let productImage3 = String(describing: String(cString: sqlite3_column_text(queryStatement, 10)))
                let productImage4 = String(describing: String(cString: sqlite3_column_text(queryStatement, 11)))
                
                psns.append(InventoryDetails(autoID: autoID, id:id, productName:productName, productCategory:productCategory, productQTY:productQTY, productCost:productCost, productDesc:productDesc, productInfo:productInfo ,productImage1:productImage1, productImage2:productImage2, productImage3:productImage3, productImage4:productImage4))
            }
        } else {
            //            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    public func updateProduct(autoId:String, id:String, productName:String, productCategory:String, productQTY:String, productCost:String, productDesc:String, productInfo:String ,productImage1:String, productImage2:String, productImage3:String, productImage4:String)
    {
        
        let updateStatementString = "UPDATE inventorytable SET uniqueID = '\(id)', product_name = '\(productName)', product_category = '\(productCategory)', product_qty = '\(productQTY)', product_cost = '\(productCost)', product_desc = '\(productDesc)', product_info = '\(productInfo)', product_image1 = '\(productImage1)', product_image2 = '\(productImage2)', product_image3 = '\(productImage3)', product_image4 = '\(productImage4)'  WHERE id = '\(autoId)';"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                //                print("Successfully updated row.")
            } else {
                //                print("Could not update row.")
            }
        } else {
            //            print("UPDATE statement could not be prepared")
        }
        sqlite3_finalize(updateStatement)
    }
    
    public func updateProductImagesPath(autoId:String, id:String, productImage1:String, productImage2:String, productImage3:String, productImage4:String)
    {
        let updateStatementString = "UPDATE inventorytable SET uniqueID = '\(id)', product_image1 = '\(productImage1)', product_image2 = '\(productImage2)', product_image3 = '\(productImage3)', product_image4 = '\(productImage4)'  WHERE id = '\(autoId)';"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                //                print("Successfully updated row.")
            } else {
                //                print("Could not update row.")
            }
        } else {
            //            print("UPDATE statement could not be prepared")
        }
        sqlite3_finalize(updateStatement)
    }
    
    public func updateProduct(autoId:String, id:String, productQTY:String)
    {
        
        let updateStatementString = "UPDATE inventorytable SET uniqueID = '\(id)', product_qty = '\(productQTY)'  WHERE id = '\(autoId)';"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                //                print("Successfully updated row.")
            } else {
                //                print("Could not update row.")
            }
        } else {
            //            print("UPDATE statement could not be prepared")
        }
        sqlite3_finalize(updateStatement)
    }
    
    //MARK:- Delete call
    public func deleteDetails(queryStatement : String, id : String) {
        let deleteStatementStirng = queryStatement
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(deleteStatement, 1, id, -1, nil)
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                //                print("Successfully deleted row.")
            } else {
                //                print("Could not delete row.")
            }
        } else {
            //            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
}
