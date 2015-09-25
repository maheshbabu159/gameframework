//
//  SetupData.swift
//  
//
//  Created by apple on 9/10/15.
//
//

@objc(SetupData)
class SetupData: NSManagedObject {

    @NSManaged var cities: AnyObject
    @NSManaged var courses: AnyObject
    @NSManaged var classTypes: AnyObject
    @NSManaged var courseCategories: AnyObject
    @NSManaged var roles: AnyObject

}
