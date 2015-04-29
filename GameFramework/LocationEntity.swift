//
//  LocationEntity.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 4/29/15.
//  Copyright (c) 2015 apple. All rights reserved.
//


@objc(LocationEntity)
class LocationEntity: NSManagedObject {
    
    @NSManaged var location_id: Int
    @NSManaged var title: String
    
    
}


