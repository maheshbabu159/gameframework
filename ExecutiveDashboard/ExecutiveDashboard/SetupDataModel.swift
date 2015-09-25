//
//  GetSetupDataModel.swift
//  HTI
//
//  Created by apple on 9/10/15.
//
//

import UIKit

class SetupDataModel: NSObject {
   
    class func initWithDictionary(rootDictionary:NSDictionary){
        
        
        //Convert dictionary values to managed data object.
        if let resultDictionary = rootDictionary["result"] as? NSDictionary{
            
            let object = SetupData.MR_createEntity() as SetupData

            if let citiesArray = resultDictionary["cities"] as? NSArray{

                object.cities = citiesArray
            }
            if let classTypesArray = resultDictionary["classTypes"] as? NSArray{
                
                object.classTypes = classTypesArray
            }
            if let courseCategoriesArray = resultDictionary["courseCategories"] as? NSArray{
                
                object.courseCategories = courseCategoriesArray
            }
            if let coursesArray = resultDictionary["courses"] as? NSArray{
                
                object.courses = coursesArray
            }
            if let rolesArray = resultDictionary["roles"] as? NSArray{
                
                object.roles = rolesArray
            }
            if let statesArray = resultDictionary["states"] as? NSArray{
                
                object.roles = statesArray
            }
        }
    
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
    
    class func getAllClassobjects() -> NSArray{
        
        let objectsArray =  SetupData.MR_findAll() as NSArray
        
        return objectsArray
        
    }
    
    class func getAllCities() -> NSArray{
        
        var cities:NSArray = NSArray()
        
        let objectsArray =  SetupData.MR_findAll() as NSArray
        
        if objectsArray.count > 0 {
            
            if let object:SetupData = objectsArray[0] as? SetupData{
                
                cities = object.cities as! NSArray
            }
        }
        
        return cities
        
    }
    class func getAllCourses() -> NSArray{
        
        var courses:NSArray = NSArray()
        
        let objectsArray =  SetupData.MR_findAll() as NSArray
        
        if objectsArray.count > 0 {
            
            if let object:SetupData = objectsArray[0] as? SetupData{
                
                courses = object.courses as! NSArray
                
            }
        }
        
        return courses
        
    }
}
