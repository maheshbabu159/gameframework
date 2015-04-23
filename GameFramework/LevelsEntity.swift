//
//  LevelsEntity.swift
//  GameFramework
//
//  Created by apple on 1/16/15.
//  Copyright (c) 2015 apple. All rights reserved.
//


@objc(LevelsEntity)
class LevelsEntity: NSManagedObject {

    @NSManaged var level_number: Int32
    @NSManaged var level_target_score_number: Int32
    @NSManaged var level_time_hours: Int32
    @NSManaged var level_time_min: Int32
    @NSManaged var level_time_sec: Int32

}
