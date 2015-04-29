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

    @NSManaged var match_id: Int
    @NSManaged var tournment: String
    @NSManaged var date: String
    @NSManaged var location: String
    @NSManaged var home_team_name: String
    @NSManaged var guest_team_name: String
    @NSManaged var home_team_tries: Int
    @NSManaged var guest_team_tries: Int
    @NSManaged var home_team_penalties: Int
    @NSManaged var guest_team_penalties: Int
    @NSManaged var home_team_filed_goals: Int
    @NSManaged var guest_team_filed_goals: Int
    @NSManaged var home_team_conversations: Int
    @NSManaged var guest_team_conversations: Int
    @NSManaged var home_team_total_points: Int
    @NSManaged var guest_team_total_points: Int

}
