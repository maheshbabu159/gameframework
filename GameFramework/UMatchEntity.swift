//
//  UMatchEntity.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 4/28/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import Foundation

class UMatchEntity: NSObject {

    var match_id: Int = 0
    var tournment: String = ""
    var date: String = ""
    var location: String = ""
    var home_team_name: String = ""
    var guest_team_name: String = ""
    var home_team_tries: Int = 0
    var guest_team_tries: Int = 0

    var home_team_penalties: Int = 0
    var guest_team_penalties: Int = 0
    var home_team_filed_goals: Int = 0
    var guest_team_filed_goals: Int = 0
    var home_team_conversations: Int = 0
    var guest_team_conversations: Int = 0
    var home_team_total_points: Int = 0
    var guest_team_total_points: Int = 0
}
