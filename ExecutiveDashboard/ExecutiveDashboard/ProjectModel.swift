//
//  ProjectModel.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 6/25/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit

class ProjectModel: Project {
    
    //Method to parse dictionary and save it in database
    class func initWithDictionary(aDictionary:NSDictionary){
        
        
        //Convert dictionary values to managed data object.
        if let resultArray = aDictionary["result"] as? NSArray{
            
            for resultDictionary in resultArray {
               
                //Creating managed object to save in database
                let object = Project.MR_createEntity() as Project
                
                if let type = resultDictionary["__type"] as? NSString {
                    
                    object.type = type as String;
                    
                }
                if let className:NSString = resultDictionary["className"] as? NSString {
                    
                    object.class_name = className as String;
                    
                }
                if let createdAt:NSString = resultDictionary["createdAt"] as? NSString {
                    
                    object.createdAt = createdAt as String;
                    
                }
                if let objectId:NSString = resultDictionary["objectId"] as? NSString {
                    
                    object.objectId = objectId as String;
                    
                }
                
                if let platform:NSString = resultDictionary["platform"] as? NSString {
                    
                    object.platform = platform as String;
                    
                }
                if let projectCount:Int = resultDictionary["projectCount"] as? Int {
                    
                    object.projectCount =  "\(projectCount)";
                    
                    
                }
                if let updatedAt:NSString = resultDictionary["updatedAt"] as? NSString {
                    
                    object.updatedAt = updatedAt as String;
                    
                }

                
            }
           
        }
        //Save changes to database
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
    
    //Method to delete all the objects from database
    class func deleteAllProjectObjects(){
        
        Project.MR_truncateAll()
        
        //Save changes to database
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        
    }
    //Method to get total of visits all the objects from database
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
        
        let array:NSArray =  Project.MR_findAll() as! [Project]!

        return array.count

    }
    
    //Method to delete all the objects from database
    class func getAllProjectObjects() -> NSArray{
        
        let array =  Project.MR_findAll() as? [Project]
        
        return array!
        
    }
}
