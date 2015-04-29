//
//  TournmentEntity.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 4/29/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

@objc(TournmentEntity)
class TournmentEntity: NSManagedObject {
    
    @NSManaged var tournment_id: Int
    @NSManaged var title: String
  
    
}
