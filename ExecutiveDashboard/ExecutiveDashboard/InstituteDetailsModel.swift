//
//  InstituteDetailsModel.swift
//  HTI
//
//  Created by apple on 9/12/15.
//
//

import UIKit

class InstituteDetailsModel: NSObject {
   
    
    class func initWithDictionary(rootDictionary:NSDictionary){
        
        
        //Convert dictionary values to managed data object.
        if let resultDictionary = rootDictionary["result"] as? NSDictionary{
            
            let object = InstituteDetails.MR_createEntity() as InstituteDetails
            
            if let trainersArray = resultDictionary["trainers"] as? NSArray{
                
                object.trainersArray = trainersArray
            }
            if let commentsArray = resultDictionary["comments"] as? NSArray{
                
                object.commentsArray = commentsArray
            }
            if let classDetailsArray = resultDictionary["classDetails"] as? NSArray{
                
                object.classDetailsArray = classDetailsArray
            }
            if let instituteDetailsDictionary = resultDictionary["instituteDetails"] as? NSDictionary{
                
                object.instituteDetailsDictionary = instituteDetailsDictionary
            }
        }
        
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
    
    class func getAllClassobjects() -> NSArray{
        
        let objectsArray =  InstituteDetails.MR_findAll() as NSArray
        
        return objectsArray
        
    }
    //Method to delete all the objects from database
    class func deleteAllObjects(){
        
        InstituteDetails.MR_truncateAll()
        
        //Save changes to database
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        
    }
    class func getAllComments() -> NSArray{
        
        var comments:NSArray = NSArray()
        
        let objectsArray =  InstituteDetails.MR_findAll() as NSArray
        
        if objectsArray.count > 0 {
            
            if let object:NSManagedObject = objectsArray[0] as? NSManagedObject{
                
                comments = object.valueForKey("commentsArray") as! NSArray
            }
        }
        
        return comments
        
    }
    class func getAllTrainers() -> NSArray{
        
        var trainers:NSArray = NSArray()
        
        let objectsArray =  InstituteDetails.MR_findAll() as NSArray
        
        if objectsArray.count > 0 {
            
            if let object:NSManagedObject = objectsArray[0] as? NSManagedObject{
                
                trainers = object.valueForKey("trainersArray") as! NSArray
            }
        }
        
        return trainers
        
    }
    class func getAllClassDetails() -> NSArray{
        
        var classDetails:NSArray = NSArray()
        
        let objectsArray =  InstituteDetails.MR_findAll() as NSArray
        
        if objectsArray.count > 0 {
            
            if let object:NSManagedObject = objectsArray[0] as? NSManagedObject{
                
                classDetails = object.valueForKey("classDetailsArray") as! NSArray
            }
        }
        return classDetails
    }

}
