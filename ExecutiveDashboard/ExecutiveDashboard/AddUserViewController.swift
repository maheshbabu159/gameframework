//
//  AddUserViewController.swift
//  HTI
//
//  Created by Training on 8/10/15.
//
//

import UIKit
import AFNetworking
import MBProgressHUD

class AddUserViewController: UIViewController {

       override func viewDidLoad() {
        super.viewDidLoad()
       // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func addUserButtonClick(sender: UIButton) {
        self.performSegueWithIdentifier("addUserViewControllerToUserRgistrationViewControllerSegue", sender: self)
    }
        
   
    
    
    func addUserServiceCall(username:NSString, password:NSString){
        
        
        let params = ["username": "\(username)","password": "\(password)"]
        
        let manager = NetworkManager.initAFNetworkManager()
        
        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
        manager.POST(GlobalVariables.request_url + (GlobalVariables.RequestAPIMethods.AddUser.rawValue as String),parameters: params,
            
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                //Hide progress bar
                progressHUD.hide(true)
                println(responseObject.description)
                
                let jsonDictionary = responseObject as! Dictionary<String, AnyObject>
                
                //return (true, rootDictionary)
                
                if let resultString:NSString = jsonDictionary["result"] as? NSString {
                    
                    println(resultString)
                    
                    if(resultString.isEqualToString("User login successful")){
                        
                        self.performSegueWithIdentifier("signinToTableSegue", sender: self)
                        
                    }else{
                        
                        
                        //Save session id to user defaults
                        if let sessionId:NSString = jsonDictionary["result"] as? NSString{
                            
                            GlobalSettings.udateSessionId(sessionId)
                            
                            var signedIn:Bool = GlobalVariables.globalUserDefaults.boolForKey(GlobalVariables.user_defaults_signed_in_key)
                            var remember:Bool = GlobalVariables.globalUserDefaults.boolForKey(GlobalVariables.user_defaults_remember_me_key)
                            
                            if(signedIn&&remember){
                                
                                var sessionId:NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_session_id_key) as! NSString
                                let jsonString:NSString = "{\"sessionId\":\"\(sessionId)\"}"
                                //Send registration request
                                NetworkManager.registerDeviceServiceCall("RegisterDevice", bodyData: jsonString, viewController: self)
                                
                            }else{
                                
                                //self.showDatePickerInAlert(0, title: "From Date")
                                
                            }
                            
                            
                            //Update default value
                            GlobalSettings.updateSignedInDefaultValue(true)
                            
                            
                        }else{
                            
                            let alertController = UIAlertController(title:"Executive Dashboard", message:"Session id not recieved."
                                , preferredStyle: UIAlertControllerStyle.Alert)
                            
                            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                            
                            self.presentViewController(alertController, animated: true, completion: nil)
                        }
                        
                        
                    }
                    
                }
                
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                
                
                //Hide progress bar
                progressHUD.hide(true)
                
                let alertController = UIAlertController(title:"Executive Dashboard", message:error.description
                    , preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        )
        
    }

    
    
}
