//
//  User.swift
//  HTI
//
//  Created by Training on 8/8/15.
//
//

@objc(User)
class User: NSManagedObject {
    
    @NSManaged var username: String
    @NSManaged var password: String
    @NSManaged var objectId: String
    @NSManaged var emailVerified: Bool
    @NSManaged var email: String
    @NSManaged var updatedAt: String
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var phoneNumber: String
    @NSManaged var type: String
    @NSManaged var roleId: String
    @NSManaged var cityname: String
    
    //@NSManaged var className: String

   
}
