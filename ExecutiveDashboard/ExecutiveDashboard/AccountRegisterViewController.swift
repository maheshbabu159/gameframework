//
//  AccountRegisterViewController.swift
//  HTI
//
//  Created by Training on 8/29/15.
//
//

import UIKit
import QuartzCore
import MaterialKit
import AFNetworking
import MBProgressHUD



class AccountRegisterViewController: UIViewController {

    
    @IBOutlet weak private var usernameTextFiled:MKTextField!
    @IBOutlet weak private var passwordTextFiled:MKTextField!
    @IBOutlet weak private var confirmPasswordTextField:MKTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setControlProperties()
    }
    func setControlProperties(){
        
        
        // No border, no shadow, floatingPlaceholderEnabled
        usernameTextFiled.layer.borderColor = UIColor.clearColor().CGColor
        usernameTextFiled.floatingPlaceholderEnabled = true
        usernameTextFiled.placeholder = "Username"
        usernameTextFiled.tintColor = UIColor.MKColor.Blue
        usernameTextFiled.rippleLocation = .Right
        usernameTextFiled.cornerRadius = 0
        usernameTextFiled.bottomBorderEnabled = true
        
        passwordTextFiled.layer.borderColor = UIColor.clearColor().CGColor
        passwordTextFiled.floatingPlaceholderEnabled = true
        passwordTextFiled.placeholder = "Password"
        passwordTextFiled.tintColor = UIColor.MKColor.Blue
        passwordTextFiled.rippleLocation = .Right
        passwordTextFiled.cornerRadius = 0
        passwordTextFiled.bottomBorderEnabled = true
        
        confirmPasswordTextField.layer.borderColor = UIColor.clearColor().CGColor
        confirmPasswordTextField.floatingPlaceholderEnabled = true
        confirmPasswordTextField.placeholder = "Confirm Password"
        confirmPasswordTextField.tintColor = UIColor.MKColor.Blue
        confirmPasswordTextField.rippleLocation = .Right
        confirmPasswordTextField.cornerRadius = 0
        confirmPasswordTextField.bottomBorderEnabled = true

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func RegisterButtonClick(sender: AnyObject){
        
        let usernameTextFiled:MKTextField = self.view.viewWithTag(1002) as! MKTextField
        let passwordTextFiled:MKTextField = self.view.viewWithTag(1003) as! MKTextField
        let confirmPasswordTextField:MKTextField = self.view.viewWithTag(1004) as! MKTextField
        
        if(usernameTextFiled.text == ""){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: "Please enter valid email id", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else if(passwordTextFiled.text == ""){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: "Please enter your password.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            }
        
        else if(confirmPasswordTextField.text == ""){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: " Please conform your password.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }else if(confirmPasswordTextField.text != passwordTextFiled.text){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: " password didn't match ", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

        
        else{
            
         signupService()
        
        }
        
    }
    
    func signupService(){
        
        
        let emailTextFiled:MKTextField = self.view.viewWithTag(1002) as! MKTextField
        let passwordTextFiled:MKTextField = self.view.viewWithTag(1003) as! MKTextField
        let confirmPasswordTextField:MKTextField = self.view.viewWithTag(1004) as! MKTextField
        
        var roleId:String = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_role_id_key) as! String

        let params = ["roleId": "\(roleId)","email": "\(emailTextFiled.text)","password": "\(passwordTextFiled.text)","method":"\(GlobalVariables.RequestAPIMethods.SignUp.rawValue as String)"]
        
        
        let manager = NetworkManager.initAFNetworkManager()
        
        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
        
        manager.POST(GlobalVariables.request_url ,parameters: params,
            
            success: {(operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                //Hide progress bar
                progressHUD.hide(true)
                println(responseObject.description)
                
                let jsonDictionary = responseObject as! Dictionary<String, AnyObject>
                
                //return (true, rootDictionary)
                
                if let resultString:NSString = jsonDictionary["result"] as? NSString {
                    
                    println(resultString)
                    
                    if(resultString.isEqualToString("User login successful")){
                        
                        self.performSegueWithIdentifier("AccountRegisterViewController", sender: self)
                        //self.navigationController?.popViewControllerAnimated(true)
                        
                        //if let navController = self.navigationController {
                        // navController.popViewControllerAnimated(true)
                        //  }
                        
                        
                    }
                    else{
                        
                        
                        //Save session id to user defaults
                        if let sessionId:NSString = jsonDictionary["result"] as? NSString{
                            
                            GlobalSettings.udateSessionId(sessionId)
                            
                            var signedIn:Bool = GlobalVariables.globalUserDefaults.boolForKey(GlobalVariables.user_defaults_signed_in_key)
                            var remember:Bool = GlobalVariables.globalUserDefaults.boolForKey(GlobalVariables.user_defaults_remember_me_key)
                            
                            if(signedIn&&remember){
                                
                                var sessionId:NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_session_id_key)as! NSString
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
