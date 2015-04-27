//
//  CategoryEntity.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 4/27/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import Foundation
import CoreData

class CategoryEntity: NSManagedObject {

    @NSManaged var category_id: NSNumber
    @NSManaged var title: String
    @NSManaged var date: String

}