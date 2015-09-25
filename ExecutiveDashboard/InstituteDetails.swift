//
//  InstituteDetails.swift
//  
//
//  Created by apple on 9/12/15.
//
//

import Foundation
import CoreData

class InstituteDetails: NSManagedObject {

    @NSManaged var classDetails: AnyObject
    @NSManaged var comments: AnyObject
    @NSManaged var instituteDetails: AnyObject
    @NSManaged var trainers: AnyObject

}
