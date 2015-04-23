//
//  GlobalSettings.swift
//  GameFramework
//
//  Created by apple on 1/16/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import Foundation

class GlobalSettings {
    
    class func increaseAppIterationNumber(){
        
        var iterationNumber = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_app_iteration_number_key)
        
        iterationNumber = iterationNumber+1;
        
        GlobalVariables.globalUserDefaults.setInteger(iterationNumber, forKey: GlobalVariables.user_defaults_app_iteration_number_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    class func addUserDefaults(){
        
        
        GlobalVariables.globalUserDefaults.setInteger(0, forKey: GlobalVariables.user_defaults_app_iteration_number_key)
        
        GlobalVariables.globalUserDefaults.setBool(false, forKey: GlobalVariables.user_defaults_app_iteration_number_key)
        
        GlobalVariables.globalUserDefaults.setInteger(0,forKey:GlobalVariables.user_defaults_current_level_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()


    }
    
    class func addGameLevels() {
        
        var level1NumberIntValue       : Int32       = 1;
        var level2NumberIntValue       : Int32       = 2;
        var level3NumberIntValue       : Int32       = 3;
        var level4NumberIntValue       : Int32       = 4;

        var level1TargetScoreIntValue       : Int32       = 3;
        var level2TargetScoreIntValue       : Int32       = 10;
        var level3TargetScoreIntValue       : Int32       = 20;
        var level4TargetScoreIntValue       : Int32       = 30;

        
        //Adding levels to array

        let level4 = LevelsEntity.createEntity() as LevelsEntity
        level4.level_number = level4NumberIntValue
        level4.level_target_score_number = level4TargetScoreIntValue
        
        let level3 = LevelsEntity.createEntity() as LevelsEntity
        level3.level_number = level3NumberIntValue
        level3.level_target_score_number = level3TargetScoreIntValue
     
        let level2 = LevelsEntity.createEntity() as LevelsEntity
        level2.level_number = level2NumberIntValue
        level2.level_target_score_number = level2TargetScoreIntValue
       
        let level1 = LevelsEntity.createEntity() as LevelsEntity
        level1.level_number = level1NumberIntValue
        level1.level_target_score_number = level1TargetScoreIntValue
        
    
        
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
        
        
    }
    
}