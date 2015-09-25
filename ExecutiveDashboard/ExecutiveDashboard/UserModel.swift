//
//  UserModel.swift
//  HTI
//
//  Created by Training on 8/8/15.
//
//

import UIKit
import MagicalRecord
class UserModel: User {

class func initWithDictionary(aDictionary:NSDictionary){
        
        
        //Convert dictionary values to managed data object.
        if let resultArray = aDictionary["result"] as? NSArray{
            
            for resultDictionary in resultArray {
               
                //Creating managed object to save in database
                let object = User.MR_createEntity() as User
                
                if let type = resultDictionary["type"] as? NSString {
                    
                    object.type = type as String;
                    
                }
                if let objectId:NSString = resultDictionary["objectId"] as? NSString {
                    
                    object.objectId = objectId as String;
                    
                }
                
                if let lastName:NSString = resultDictionary["lastName"] as? NSString {
                    
                    object.lastName = lastName as String;
                    
                }
                if let firstName:NSString = resultDictionary["firstName"] as? NSString {
                    
                    object.firstName =  firstName as String;
                    
                }
                if let updatedAt:NSString = resultDictionary["updatedAt"] as? NSString {
                    
                    object.updatedAt = updatedAt as String;
                    
                }
                if let username:NSString = resultDictionary["username"] as? NSString {
                    
                    object.username = username as String;
                    
                }
                if let email:NSString = resultDictionary["email"] as? NSString {
                    
                    object.email = email as String;
                    
                }
                if let phoneNumber:NSString = resultDictionary["phoneNumber"] as? NSString {
                    
                    object.phoneNumber = phoneNumber as String;
                    
                }
                if let roleId:NSString = resultDictionary["roleId"] as? NSString {
                    
                    object.roleId = roleId as String;
                
                }
                if let emailVerified:Bool = resultDictionary["emailVerified"] as? Bool {
                    
                    object.emailVerified = emailVerified as Bool;
              
                }
                if let password:NSString = resultDictionary["password"] as? NSString {
                    
                    object.password = password as String;
                    
                }

            }
           
        }
        //Save changes to database
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
    
    class func getAllUserObjects() -> NSArray{
        
        let array =  User.MR_findAll() as NSArray
        
        return array
        
    }
    
   //Method to delete all the objects from database
    class func deleteAllUsers(){
        
        User.MR_truncateAll()
        
        //Save changes to database
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        
    }
    /*//Method to get total of visits all the objects from database
    class func getProjectsTotal()->Int{
        
        var totalCount:Int = 0
        if let array =  Project.MR_findAll() as? [Project]{
            
            for item:Project in array {
                
                totalCount = totalCount + item.projectCount.toInt()!
                
            }
            
        }
        return totalCount
        
    }
    //Method to get total of visits all the objects from database
    class func getProjectsArrayCount()->Int{
        
        let array:NSArray =  Project.MR_findAll() as [Project]!
        
        return array.count
        
    }
    
    //Method to delete all the objects from database
    class func getAllProjectObjects() -> NSArray{
        
        let array =  Project.MR_findAll() as? [Project]
        
        return array!
        
    }
*/

   
}
