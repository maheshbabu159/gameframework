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

    @NSManaged var classDetailsArray: AnyObject
    @NSManaged var commentsArray: AnyObject
    @NSManaged var instituteDetailsDictionary: AnyObject
    @NSManaged var trainersArray: AnyObject

}
