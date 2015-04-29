//
//  LocationEntity.swift
//  GameFramework
//
//  Created by apple on 4/29/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import Foundation
import CoreData

class LocationEntity: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var location_id: Int

}
