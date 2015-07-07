//
//  ProfileModel.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 6/25/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit

class ProfileModel: Profile {
   
    //Method to parse dictionary and save it in database
    class func initWithDictionary(aDictionary:NSDictionary){
      
        
        if let resultDictionary = aDictionary["result"] as? NSDictionary{
            
            //Creating managed object to save in database
            let object = Profile.createEntity() as Profile
            
            
            if let type = resultDictionary["__type"] as? NSString {
                
                object.type = type;
            
            }
            if let active:Bool = resultDictionary["active"] as? Bool {
                
                let status = active as NSNumber
                object.active = status.stringValue;
                
            }
            if let address:NSString = resultDictionary["address"] as? NSString {
                
                object.address = address;
                
            }
            if let associateId:NSString = resultDictionary["associateId"] as? NSString {
                
                object.associateId = associateId;
                
            }
            if let birthDictionary:NSDictionary = resultDictionary["birthDate"] as? NSDictionary {
                
                if let birthType:NSString = birthDictionary["__type"] as? NSString {
                    
                    object.birthDate_type = birthType;
                    
                }
                if let birthISO:NSString = birthDictionary["iso"] as? NSString {
                    
                    object.birthDate_iso = birthISO;
                    
                }
                
            }
            if let bloodGroup:NSString = resultDictionary["bloodGroup"] as? NSString {
                
                object.bloodGroup = bloodGroup;
                
            }
            if let className:NSString = resultDictionary["className"] as? NSString {
                
                object.class_name = className;

                
            }
            if let createdAt:NSString = resultDictionary["createdAt"] as? NSString {
                
                object.createdAt = createdAt;

                
            }
            if let createdBy:NSString = resultDictionary["createdBy"] as? NSString {
                
                object.createdBy = createdBy;
                
            }
            if let department:NSString = resultDictionary["department"] as? NSString {
                
                object.department = department;
                
            }
            if let designation:NSString = resultDictionary["designation"] as? NSString {
                
                object.designation = designation;

            }
            if let email:NSString = resultDictionary["email"] as? NSString {
                
                object.email = email;
                
            }
            if let firstname:NSString = resultDictionary["firstname"] as? NSString {
                
                object.firstname = firstname;
                
            }
            if let gender:NSString = resultDictionary["gender"] as? NSString {
                
                object.gender = gender;
                
            }
            if let grade:NSString = resultDictionary["grade"] as? NSString {
                
                object.grade = grade;
                
            }
            if let joinDateDictionary:NSDictionary = resultDictionary["joinDate"] as? NSDictionary {
                
                if let joinDateType:NSString = joinDateDictionary["__type"] as? NSString {
                    
                    object.joinDate_type = joinDateType;
                    
                }
                if let joinDate_iso:NSString = joinDateDictionary["iso"] as? NSString {
                    
                    object.joinDate_iso = joinDate_iso;
                    
                }
            }
            if let lastname:NSString = resultDictionary["lastname"] as? NSString {
                
                object.lastname = lastname;
                
                
            }
            if let maritalStatus:NSString = resultDictionary["maritalStatus"] as? NSString {
                
                object.maritalStatus = maritalStatus;
                
                
            }
            if let objectId:NSString = resultDictionary["objectId"] as? NSString {
                
                object.objectId = objectId;
                
                
            }
            if let phone:NSString = resultDictionary["phone"] as? NSString {
                
                object.phone = phone;
                
                
            }
            if let photoDictionary:NSDictionary = resultDictionary["photo"] as? NSDictionary {
                
                
                if let photoType:NSString = photoDictionary["__type"] as? NSString {
                    
                    object.photo_type = photoType;
                    
                }
                if let photo_name:NSString = photoDictionary["name"] as? NSString {
                    
                    object.photo_name = photo_name;
                    
                }
                if let photo_url:NSString = photoDictionary["url"] as? NSString {
                    
                    object.photo_url = photo_url;
                    
                }

            }
            if let reportingTo:NSString = resultDictionary["reportingTo"] as? NSString {
                
                object.reportingTo = reportingTo;
                
                
            }
            if let updatedAt:NSString = resultDictionary["updatedAt"] as? NSString {
                
                object.updatedAt = updatedAt;
                
            }
            if let userId:NSString = resultDictionary["userId"] as? NSString {
                
                object.userId = userId;
                
                
            }
        }

        //End of parsing dictionary
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()

    }
    //Method to delete all the objects from database
    class func deleteAllProfiles(){
        
        
        Profile.truncateAll()
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()

    }
    //Method to delete all the objects from database
    class func getAllProfileObjects() -> NSArray {
        
        let profilesArray = Profile.findAll() as NSArray
    
        return profilesArray
    }
}
