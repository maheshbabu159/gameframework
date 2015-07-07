//
//  WebsiteVisitsEntityModel.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 6/22/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit

class WebsiteVisitModel: WebsiteVisit {
   
    
    //Method to parse dictionary and save it in database
    class func initWithDictionary(aDictionary:NSDictionary){
        
        //Convert dictionary values to managed data object.
        if let resultArray = aDictionary["result"] as? NSArray{
          
            for resultDictionary in resultArray {
            
                //Creating managed object to save in database
                let object = WebsiteVisit.createEntity() as WebsiteVisit
                
                if let type = resultDictionary["__type"] as? NSString {
                    
                    object.type = type;
                    
                }
                if let className:NSString = resultDictionary["className"] as? NSString {
                    
                    object.class_name = className;
                    
                }
                if let count:Int = resultDictionary["count"] as? Int {
                    
                    object.count = "\(count)"
                    
                }
                if let objectId:NSString = resultDictionary["objectId"] as? NSString {
                    
                    object.objectId = objectId
                    
                }
                
                if let createdAt:NSString = resultDictionary["createdAt"] as? NSString {
                    
                    object.createdAt = createdAt
                    
                }
                if let month:Int = resultDictionary["month"] as? Int {
                    
                    object.month = "\(month)"
                    
                    
                }
                if let updatedAt:NSString = resultDictionary["updatedAt"] as? NSString {
                    
                    object.updatedAt = updatedAt
                    
                    
                }
                if let year:Int = resultDictionary["year"] as? Int {
                    
                    object.year = "\(year)"
                    
                }
                  println(object.count)
            }
           
        }
        
      
        //Save changes to database
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
    }
    
    //Method to delete all the objects from database
    class func deleteAllWebsiteVisitObjects(){
        
        WebsiteVisit.truncateAll()
        
        //Save changes to database
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
        
    }
    //Method to delete all the objects from database
    class func getAllWebsiteVisitObjects() -> NSArray{
        
        let array =  WebsiteVisit.findAll() as? [WebsiteVisit]
        
        return array!
        
    }
    
    //Method to get total of visits all the objects from database
    class func getWebsiteVisitsTotal()->Int{
        
         var totalCount:Int = 0
        if let array =  WebsiteVisit.findAll() as? [WebsiteVisit]{
            
            for item:WebsiteVisit in array {
                

                totalCount = totalCount + item.count.toInt()!
                
            }
        
        }
        return totalCount
        
    }
    
    //Method to get total of visits all the objects from database
    class func getWebsiteVisitsArrayCount()->Int{
        
        let array:NSArray =  WebsiteVisit.findAll() as [WebsiteVisit]!
        
        return array.count
        
    }
}
