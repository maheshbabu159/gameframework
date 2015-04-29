//
//  MatchEntityOperations.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 4/29/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit

class MatchEntityOperations: MatchEntity {
   
}

extension MatchEntityOperations{
    
    class func saveMatchToDatabase(aMatchEntity:UMatchEntity){
      
        let object = MatchEntity.createEntity() as MatchEntity
        
        object.match_id = GlobalSettings.getNewMatchId()
        object.tournment = "Default"
        object.location = "Default"
        object.home_team_tries = aMatchEntity.home_team_tries
       
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
    }
}