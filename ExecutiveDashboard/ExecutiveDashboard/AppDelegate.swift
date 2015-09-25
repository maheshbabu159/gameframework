//
//  AppDelegate.swift
//  GameFramework
//
//  Created by apple on 1/14/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit
import MagicalRecord
import AFNetworking
import MBProgressHUD
import MaterialKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
    
        //Change the application level navigation bar color
        UINavigationBar.appearance().barTintColor = GlobalSettings.RGBColor(GlobalVariables.yellow_color)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()

        // Override point for customization after application launch.
        //Set up magical record
        setupMagicalRecord()
        
        //Initialize global singleton
        GlobalSingleton.sharedInstance
        
        let appItertationNumber = GlobalVariables.globalUserDefaults.integerForKey(GlobalVariables.user_defaults_app_iteration_number_key)
        
        
        let frame = UIScreen.mainScreen().bounds
        window = UIWindow(frame: frame)

        
        //If the is running first time set the default values
        if(appItertationNumber==0){
            
           
           getSetupDataServiceCall()
               
                        
        }else{
            
            
            //Navigate to slider view of dashboard
            /*let containerViewController = ContainerViewController()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = containerViewController*/
            
            var cityId:String = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_city_id_key) as! String
            
            var courseId:String = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_course_id_key)as! String

            if(cityId == "" || courseId == ""){
              
                //Navigate to slider view of dashboard
                let containerViewController = ContainerViewController()
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                containerViewController.selectedIndex = 0

                if let window = self.window{
                    
                    window.rootViewController = containerViewController
                    window.makeKeyAndVisible()
                }
                
            }else{
                
                //Navigate to slider view of dashboard
                let containerViewController = ContainerViewController()
                containerViewController.selectedIndex = 1
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                if let window = self.window{
                    
                    window.rootViewController = containerViewController
                    window.makeKeyAndVisible()
                }
            }
            
            

            
        }

        //Increase iteration number
        GlobalSettings.increaseAppIterationNumber()


        return true
    }
    
    func getSetupDataServiceCall(){
        
        
        let manager = NetworkManager.initAFNetworkManager()
        
        let params = ["method":"\(GlobalVariables.RequestAPIMethods.GetSetupData.rawValue as String)"]
        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.window, animated: true)
        
        progressHUD.labelText = "Loading..."
        
        
        manager.POST(GlobalVariables.request_url ,parameters: params,
            
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                //Hide progress bar
                progressHUD.hide(true)
                println(responseObject.description)
                
                
                let jsonDictionary = responseObject as! Dictionary<String, AnyObject>
                
                SetupDataModel.initWithDictionary(jsonDictionary)

                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                var introductionViewController:IntroductionViewController = mainStoryboard.instantiateViewControllerWithIdentifier("IntroductionViewController") as! IntroductionViewController
                
                if let window = self.window{
                    
                    window.rootViewController = introductionViewController
                    window.makeKeyAndVisible()
                }

                
                
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                
                
                //Hide progress bar
                progressHUD.hide(true)
                
                let alertController = UIAlertController(title:"Executive Dashboard", message:error.description
                    , preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                
              
                self.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
              
            }
            
        )
    
    }
    

    
    func setupMagicalRecord(){
        
        MagicalRecord.enableShorthandMethods()
    
        // Setup MagicalRecord as per usual
        MagicalRecord.setupCoreDataStack()
    }
    
    
    
   
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }



}

