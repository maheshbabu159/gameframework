//
//  AppDelegate.swift
//  GameFramework
//
//  Created by apple on 1/14/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Override point for customization after application launch.
        Parse.setApplicationId("I4CiQfydHxh0z5uZaV8te5SPtr3201hLY6FLNkYX", clientKey: "VRM2SBaB5hCkxZI0iwICXLZyPAAGDTkTbMu5tcjA")
        PFFacebookUtils.initializeFacebook()
        PFTwitterUtils.initializeWithConsumerKey("3Q9hMEKqqSg4ie2pibZ2sVJuv", consumerSecret: "IEZ9wv2d1EpXNGFKGp7sAGdxRtyqtPwygyciFZwTHTGhPp4FMj")
        
        PFUser.enableAutomaticUser()
        

        //Change the application level navigation bar color
        UINavigationBar.appearance().barTintColor = GlobalSettings.RGBColor(GlobalVariables.yellow_color)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()

        // Override point for customization after application launch.
        //Set up magical record
        MagicalRecord.setupCoreDataStack();
        
        //Initialize global singleton
        GlobalSingleton.sharedInstance
    

        return true
    }
    
    func serviceCall(){
       
        
        let jsonString:NSString = "{\"username\":\"maurice\",\"password\":\"maurice\"}";
      
        var url = "https://api.parse.com/1/functions/Login"
        var remoteUrl : NSURL? = NSURL(string: url)
        
        //var url = NSURL(fileURLWithPath: "https://api.parse.com/1/functions/Login")
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: remoteUrl!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("ORY7BYT28z07dlH1rdlZoJyL2PUOiszHBItyMVSb", forHTTPHeaderField: "X-Parse-Application-Id")
        request.setValue("ZvJyc70WKYorqXsJ4DYE649JwPKJ5YEL6TilZfn5", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.setValue("\(jsonString.length)", forHTTPHeaderField: "Content-Length")
        request.HTTPMethod = "POST"
        request.HTTPBody = (jsonString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{
            ( response:NSURLResponse!,  data:NSData!, error:NSError!) -> Void in
            
            let resstr = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            
            
            println( "JSON:  \(resstr)")
        })
        
        /*let jsonString:NSString = "{\"username\":\"maurice\",\"password\":\"maurice\"}";
    
        let manager = AFHTTPRequestOperationManager()

        println( "JSON:  \(jsonString.length)") //print the good thing
        
        var headersDictionary:NSDictionary =  ["Content-Type": "application/json", "X-Parse-Application-Id": "ORY7BYT28z07dlH1rdlZoJyL2PUOiszHBItyMVSb","X-Parse-REST-API-Key":"ZvJyc70WKYorqXsJ4DYE649JwPKJ5YEL6TilZfn5"]
        
        manager.securityPolicy.allowInvalidCertificates = true;
        manager.POST("https://api.parse.com/1/functions/Login", parameters: nil,
            constructingBodyWithBlock: { (formData: AFMultipartFormData!) -> Void in
                
                //code
                formData.appendPartWithHeaders(headersDictionary, body:  (jsonString as NSString).dataUsingEncoding(NSUTF8StringEncoding))

                formData.appendPartWithHeaders(headersDictionary, body:  (jsonString as NSString).dataUsingEncoding(NSUTF8StringEncoding))
                
            } ,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                println( "JSON:  \(responseObject.description)") //print the good thing
                
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                
                println( "Error: \(error.localizedDescription)") //print the good thing
                
            }
        )*/

    }



    func oneToManyRelation(){

        var user = PFUser()
        user.username = "Mahesh"
        user.password = "password"
        user.email = "mahesh.somineni@senecaglobal.com"


        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            
            if let error = error {
                
                let errorString = error.userInfo?["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                // Hooray! Let them use the app now.
                
                PFUser.logInWithUsernameInBackground("Mahesh", password:"password") {
                    (user: PFUser?, error: NSError?) -> Void in
                    if user != nil {
                        
                        // Do stuff after successful login.
                        NSLog("Login sucess.")
                        
                        
                        var newPost = PFObject(className:"Post")
                        // Create a new Post object and create relationship with PFUser
                        newPost["textContent"] = "iPhone Application Development Training"
                        newPost["author"] = PFUser.currentUser()["username"]
                        
                        var postACL = PFACL(user: user)
                        postACL.setPublicReadAccess(true)
                        postACL.setPublicWriteAccess(true)
                        newPost.ACL = postACL
                        
                        newPost.saveInBackgroundWithBlock {(success: Bool, error: NSError?) -> Void in
                            
                            
                            let query = PFQuery(className: "Post")
                            query.whereKey("author", equalTo:PFUser.currentUser()["username"])
                            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
                                
                                if error == nil {
                                    
                                    // Query Succeeded - continue your app logic here.
                                    
                                } else {
                                    
                                    // Query Failed - handle an error.
                                    
                                    
                                }
                                
                                
                                
                            }
                        }
                        
                        
                        
                    } else {
                        
                        NSLog("Login failur.")
                        
                        // The login failed. Check error to see why.
                    }
                }
                
                
                
            } else {
                
                
                // Hooray! Let them use the app now.
                
                PFUser.logInWithUsernameInBackground("Mahesh", password:"password") {
                    (user: PFUser?, error: NSError?) -> Void in
                    if user != nil {
                        
                        // Do stuff after successful login.
                        NSLog("Login sucess.")
                        
                        
                        var newPost = PFObject(className:"Post")
                        // Create a new Post object and create relationship with PFUser
                        newPost["textContent"] = "iPhone Application Development Training"
                        newPost["author"] = PFUser.currentUser()["username"]
                        
                        var postACL = PFACL(user: user)
                        postACL.setPublicReadAccess(true)
                        postACL.setPublicWriteAccess(true)
                        newPost.ACL = postACL
                        
                        newPost.saveInBackgroundWithBlock {(success: Bool, error: NSError?) -> Void in
                            
                            
                            let query = PFQuery(className: "Post")
                            query.whereKey("author", equalTo:PFUser.currentUser()["username"])
                            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
                                
                                if error == nil {
                                    
                                    // Query Succeeded - continue your app logic here.
                                    
                                } else {
                                    
                                    // Query Failed - handle an error.
                                    
                                    
                                }
                                
                                
                                
                            }
                        }
                        
                        
                        
                    } else {
                        
                        NSLog("Login failur.")
                        
                        // The login failed. Check error to see why.
                    }
                }
                
            }
        }
        
        
        

    }
    
    
    func login(){
        
        
        PFUser.logInWithUsernameInBackground("maheshbabu", password:"Qwerty!23456") {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                NSLog("Login sucess.")

                
            } else {
                
                NSLog("Login failur.")

                // The login failed. Check error to see why.
            }
        }
    }
    func swiftOperationsAndExamples(){
        
        //Saving an object
        var gameScore = PFObject(className: "GameScore")
        gameScore.setObject(1337, forKey: "score")
        gameScore.setObject("Sean Plott", forKey: "playerName")
        gameScore.saveInBackgroundWithBlock {
            (success: Bool!, error: NSError!) -> Void in
            if (success != nil) {
                
                NSLog("Object created with id: (gameScore.objectId)")
                
            } else {
                
                NSLog("%@", error)
            }
        }
        
        
        
        //User registration
        var user = PFUser()
        user.username = "maheshbabu"
        user.password = "Qwerty!23456"
        user.email = "mahesh.somineni@senecaglobal.com"
        // other fields can be set just like with PFObject
        user["phone"] = "8464966798"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
          
            if let error = error {
                
                let errorString = error.userInfo?["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                
                
            } else {
                
                
                // Hooray! Let them use the app now.
            }
        }
        
    }
    
    // MARK: Test Data
    
    private func setupTestData() {
        let todoTitles = [
            "Build Parse",
            "Make everything awesome",
            "Go out for the longest run",
            "Do more stuff",
            "Conquer the world",
            "Build a house",
            "Grow a tree",
            "Be awesome",
            "Setup an app",
            "Do stuff",
            "Buy groceries",
            "Wash clothes"
        ];
        
        var objects: [PFObject] = Array()
        
        let query = PFQuery(className: "Todo")
        if let todos = query.findObjects() as? [PFObject] {
            if todos.count == 0 {
                for (index, title) in enumerate(todoTitles) {
                    let todo = PFObject(className: "Todo")
                    todo["title"] = title
                    todo["priority"] = index % 3
                    objects.append(todo)
                }
            }
        }
        
        let appNames = [ "Anypic", "Anywall", "f8" ]
        let appsQuery = PFQuery(className: "App")
        if let apps = appsQuery.findObjects() as? [PFObject] {
            if apps.count == 0 {
                for (index, appName) in enumerate(appNames) {
                    let bundle = NSBundle.mainBundle()
                    if let filePath = bundle.pathForResource(String(index), ofType: "png") {
                        if let data = NSData(contentsOfFile: filePath) {
                            let file = PFFile(name: filePath.lastPathComponent, data: data)
                            let object = PFObject(className: "App")
                            object["icon"] = file
                            object["name"] = appName
                            objects.append(object)
                        }
                    }
                }
            }
        }
        
        if objects.count != 0 {
            PFObject.saveAll(objects)
        }
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

