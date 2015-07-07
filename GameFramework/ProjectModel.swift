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
                let object = Project.createEntity() as Project
                
                if let type = resultDictionary["__type"] as? NSString {
                    
                    object.type = type;
                    
                }
                if let className:NSString = resultDictionary["className"] as? NSString {
                    
                    object.class_name = className;
                    
                }
                if let createdAt:NSString = resultDictionary["createdAt"] as? NSString {
                    
                    object.createdAt = createdAt;
                    
                }
                if let objectId:NSString = resultDictionary["objectId"] as? NSString {
                    
                    object.objectId = objectId;
                    
                }
                
                if let platform:NSString = resultDictionary["platform"] as? NSString {
                    
                    object.platform = platform;
                    
                }
                if let projectCount:Int = resultDictionary["projectCount"] as? Int {
                    
                    object.projectCount =  "\(projectCount)";
                    
                    
                }
                if let updatedAt:NSString = resultDictionary["updatedAt"] as? NSString {
                    
                    object.updatedAt = updatedAt;
                    
                    
                }

                
            }
            
           

        }
        //Save changes to database
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
    }
    
    //Method to delete all the objects from database
    class func deleteAllProjectObjects(){
        
        Project.truncateAll()
        
        //Save changes to database
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
        
    }
    //Method to get total of visits all the objects from database
    class func getProjectsTotal()->Int{
        
        var totalCount:Int = 0
        if let array =  Project.findAll() as? [Project]{
            
            for item:Project in array {
                
                totalCount = totalCount + item.projectCount.toInt()!
                
            }
            
        }
        return totalCount
        
    }
    //Method to get total of visits all the objects from database
    class func getProjectsArrayCount()->Int{
        
        let array:NSArray =  Project.findAll() as [Project]!

        return array.count

    }
    
    //Method to delete all the objects from database
    class func getAllProjectObjects() -> NSArray{
        
        let array =  Project.findAll() as? [Project]
        
        return array!
        
    }
}
