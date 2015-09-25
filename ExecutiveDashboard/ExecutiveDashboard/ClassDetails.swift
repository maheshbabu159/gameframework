//
//  Classdetails.swift
//  
//
//  Created by Development on 9/5/15.
//
//

import Foundation
import CoreData

class ClassDetails: NSManagedObject {

    @NSManaged var city: AnyObject
    @NSManaged var classType: AnyObject
    @NSManaged var course: AnyObject
    @NSManaged var instituteDetail: AnyObject
    @NSManaged var trainerDetail: AnyObject
    @NSManaged var class_name: String
    @NSManaged var updatedAt: String
    @NSManaged var createdAt: String
    @NSManaged var objectId: String

}
