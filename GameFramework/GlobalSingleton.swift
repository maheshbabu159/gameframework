//
//  GlobalSingleton.swift
//  GameFramework
//
//  Created by apple on 1/14/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import Foundation

class GlobalSingleton {
 
    struct Static {
        
        static var instance: GlobalSingleton?
        static var token: dispatch_once_t = 0
        static var current_score : Int32 = 0
        static var rootMatchEntity : MatchEntity!
    }

    class var sharedInstance: GlobalSingleton {
       
        
        dispatch_once(&Static.token) {
           
            Static.instance = GlobalSingleton()
            
            
            let appItertationNumber = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_app_iteration_number_key)
            
            
            //If the is running first time set the default values
            if(appItertationNumber==0){
                
                GlobalSettings.addUserDefaults()
                //GlobalSettings.addGameLevels()
                Static.rootMatchEntity = MatchEntity()
                
            }
        }
        
        GlobalSettings.increaseAppIterationNumber()
        return Static.instance!
    }
    
    func getRootMatch() -> MatchEntity {
     
        return Static.rootMatchEntity
    }
    
    func setRootMatch(rootMatch:MatchEntity) {
        
        Static.rootMatchEntity = rootMatch
    }
    
       
    
    func getCurrentLevel()->Int{
        
        
        return GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_current_level_key);
        
        
    }
    
    func setCurrentLevel(current_level:Int) {
        
        
        GlobalVariables.globalUserDefaults.setInteger(current_level,forKey:GlobalVariables.user_defaults_current_level_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
        
    }

}