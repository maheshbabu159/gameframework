//
//  TournmentEntity.swift
//  GameFramework
//
//  Created by apple on 4/29/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import Foundation
import CoreData

class TournmentEntity: NSManagedObject {

    @NSManaged var tournment_id: Int
    @NSManaged var title: String

}
