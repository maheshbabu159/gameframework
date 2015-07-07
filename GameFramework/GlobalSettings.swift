//
//  GlobalSettings.swift
//  GameFramework
//
//  Created by apple on 1/16/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import Foundation

class GlobalSettings {
    
    class func addUserDefaults(){
        
        
        GlobalVariables.globalUserDefaults.setInteger(0, forKey: GlobalVariables.user_defaults_app_iteration_number_key)
        
        GlobalVariables.globalUserDefaults.setBool(false, forKey: GlobalVariables.user_defaults_app_purchased_flag_key)
        
        GlobalVariables.globalUserDefaults.setInteger(-1,forKey:GlobalVariables.user_defaults_match_id_key)
        
        GlobalVariables.globalUserDefaults.setInteger(-1,forKey:GlobalVariables.user_defaults_location_id_key)
        
        GlobalVariables.globalUserDefaults.setInteger(-1,forKey:GlobalVariables.user_defaults_tournment_id_key)
        
        GlobalVariables.globalUserDefaults.setBool(false,forKey:GlobalVariables.user_defaults_remember_me_key)
     
        GlobalVariables.globalUserDefaults.setBool(false,forKey:GlobalVariables.user_defaults_signed_in_key)

        GlobalVariables.globalUserDefaults.setValue("", forKey: GlobalVariables.user_defaults_session_id_key)
      
        GlobalVariables.globalUserDefaults.setValue("", forKey: GlobalVariables.user_defaults_username_key)
    
        GlobalVariables.globalUserDefaults.setValue("", forKey: GlobalVariables.user_defaults_password_key)

        NSUserDefaults.standardUserDefaults().synchronize()
        
        
    }
    class func increaseAppIterationNumber(){
        
        var iterationNumber = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_app_iteration_number_key)
        
        iterationNumber = iterationNumber+1;
        
        GlobalVariables.globalUserDefaults.setInteger(iterationNumber, forKey: GlobalVariables.user_defaults_app_iteration_number_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    
    class func udateSessionId(value:NSString){
        
        GlobalVariables.globalUserDefaults.setValue(value, forKey: GlobalVariables.user_defaults_session_id_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }

    class func getNewMatchId() -> Int{
        
        var currentValue = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_match_id_key)
        
        currentValue = currentValue+1;
        
        GlobalVariables.globalUserDefaults.setInteger(currentValue, forKey: GlobalVariables.user_defaults_match_id_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        return GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_match_id_key)
        
    }
    
    class func getNewLocationId() -> Int{
        
        var currentValue = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_location_id_key)
        
        currentValue = currentValue+1;
        
        GlobalVariables.globalUserDefaults.setInteger(currentValue, forKey: GlobalVariables.user_defaults_location_id_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
    
        return GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_location_id_key)
    }
    
    
    class func updateRemeberMeDefaultValue(boolValue : Bool){
        
        GlobalVariables.globalUserDefaults.setBool(boolValue, forKey: GlobalVariables.user_defaults_remember_me_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()

    }

    class func updateSignedInDefaultValue(boolValue : Bool){
        
        
        GlobalVariables.globalUserDefaults.setBool(boolValue, forKey: GlobalVariables.user_defaults_signed_in_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    class func updateUsernameDefaultValue(value : NSString){
        
        
        GlobalVariables.globalUserDefaults.setValue(value, forKey: GlobalVariables.user_defaults_username_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    class func updatePasswordDefaultValue(value : NSString){
        
        GlobalVariables.globalUserDefaults.setValue(value, forKey: GlobalVariables.user_defaults_password_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    class func getNewTournmentId()-> Int{
        
        var currentValue = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_tournment_id_key)
        
        currentValue = currentValue+1;
        
        GlobalVariables.globalUserDefaults.setInteger(currentValue, forKey: GlobalVariables.user_defaults_tournment_id_key)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        return GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_tournment_id_key)
        
    }

   
    class func addDefaultData(){
    
        let defaultTournment = TournmentEntity.createEntity() as TournmentEntity
        let defaultLocation = LocationEntity.createEntity() as LocationEntity

        defaultTournment.tournment_id = GlobalSettings.getNewTournmentId()
        defaultTournment.title = "Default"
       
        defaultLocation.location_id = GlobalSettings.getNewLocationId()
        defaultLocation.title = "Default"
        
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()

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
    // MARK: Colours functions
    class func RGBA(#r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)->UIColor{
        
        let color: UIColor = UIColor( red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: CGFloat(a) )
        return color
    }
    
    class func RGBColor(hexColor : NSString) -> UIColor{
        
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hexColorCode = hexColor as String
        
        if hexColorCode.hasPrefix("#")
        {
            let index   = advance(hexColorCode.startIndex, 1)
            let hex     = hexColorCode.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            
            if scanner.scanHexLongLong(&hexValue)
            {
                if countElements(hex) == 6
                {
                    red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF) / 255.0
                }
                else if countElements(hex) == 8
                {
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                }
                else
                {
                    print("invalid hex code string, length should be 7 or 9")
                }
            }
            else
            {
                println("scan hex error")
            }
        }
        
        let color: UIColor =  UIColor(red:CGFloat(red), green: CGFloat(green), blue:CGFloat(blue), alpha: 1.0)
        return color
    }
}