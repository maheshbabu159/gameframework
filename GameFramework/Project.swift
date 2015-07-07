//
//  Project.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 6/29/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

@objc(Project)
class Project: NSManagedObject {

    @NSManaged var class_name: String
    @NSManaged var createdAt: String
    @NSManaged var objectId: String
    @NSManaged var platform: String
    @NSManaged var projectCount: String
    @NSManaged var type: String
    @NSManaged var updatedAt: String

}
