//
//  MatchEntity.swift
//  GameFramework
//
//  Created by apple on 4/28/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import Foundation
import CoreData

class MatchEntity: NSManagedObject {

    @NSManaged var match_id: NSNumber
    @NSManaged var tournment: String
    @NSManaged var date: String
    @NSManaged var location: String
    @NSManaged var home_team_name: String
    @NSManaged var guest_team_name: String
    @NSManaged var home_team_tries: NSNumber
    @NSManaged var home_team_penalties: NSNumber
    @NSManaged var guest_team_penalties: NSNumber
    @NSManaged var home_team_filed_goals: NSNumber
    @NSManaged var guest_team_filed_goals: String
    @NSManaged var home_team_conversations: NSNumber
    @NSManaged var guest_team_conversations: NSNumber
    @NSManaged var home_team_total_points: NSNumber
    @NSManaged var guest_team_total_points: NSNumber

}
