//
//  ClassDetailsModel.swift
//  HTI
//
//  Created by Development on 9/5/15.
//
//

import UIKit
import MagicalRecord

class ClassDetailsModel: ClassDetails {
   
    class func initWithDictionary(aDictionary:NSDictionary){
        
        
        //Convert dictionary values to managed data object.
        
        if let resultArray = aDictionary["result"] as? NSArray{
            
            for resultDictionary in resultArray {
                
                //Creating managed object to save in database
                let object = ClassDetails.MR_createEntity() as ClassDetails
                
                if let class_name = resultDictionary["className"] as? NSString {
                    
                    object.class_name = class_name as String;
                    
                }
                if let city:NSDictionary = resultDictionary["city"] as? NSDictionary{
                    
                    object.city = city as NSDictionary
                    
                }
                
                if let updatedAt:NSString = resultDictionary["updatedAt"] as? NSString {
                    
                    object.updatedAt = updatedAt as String;
                    
                }
                if let createdAt:NSString = resultDictionary["createdAt"] as? NSString {
                    
                    object.createdAt =  createdAt as String;
                    
                }
                if let objectId:NSString = resultDictionary["objectId"] as? NSString {
                    
                    object.objectId = objectId as String;
                    
                }
                if let course:NSDictionary = resultDictionary["course"] as? NSDictionary {
                    
                    object.course = course as NSDictionary;
                    
                }
                if let instituteDetail:NSDictionary = resultDictionary["instituteDetail"] as? NSDictionary {
                    
                    object.instituteDetail =  instituteDetail as NSDictionary;
                    
                }
                if let trainerDetail:NSDictionary = resultDictionary["trainerDetail"] as? NSDictionary {
                    
                    object.trainerDetail = trainerDetail as NSDictionary;
                    
                }
               
                if let classType:NSDictionary = resultDictionary["classType"] as? NSDictionary {
                    
                    object.classType = classType as NSDictionary;
                    
                }
            }
        }
        
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
   
    class func getAllClassobjects() -> NSArray{
        
        let classDetailArray =  ClassDetails.MR_findAll() as NSArray
        
        return classDetailArray
        
    }
    class func deleteAllClassDetails(){
        
        ClassDetails.MR_truncateAll()
        
        //Save changes to database
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        
    }
    
    


}
