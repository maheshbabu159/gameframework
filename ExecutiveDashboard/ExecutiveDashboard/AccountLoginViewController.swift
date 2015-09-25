//
//  AccountLoginViewController.swift
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

class AccountLoginViewController: UIViewController {

    @IBOutlet weak private var usernameTextFiled:MKTextField!
    @IBOutlet weak private var passwordTextFiled:MKTextField!
    
    
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
        usernameTextFiled.tintColor = UIColor.MKColor.Green
        usernameTextFiled.rippleLocation = .Right
        usernameTextFiled.cornerRadius = 0
        usernameTextFiled.bottomBorderEnabled = true
        
        passwordTextFiled.layer.borderColor = UIColor.clearColor().CGColor
        passwordTextFiled.floatingPlaceholderEnabled = true
        passwordTextFiled.placeholder = "Password"
        passwordTextFiled.tintColor = UIColor.MKColor.Green
        passwordTextFiled.rippleLocation = .Right
        passwordTextFiled.cornerRadius = 0
        passwordTextFiled.bottomBorderEnabled = true
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginButtonClick(sender: AnyObject){
    
        let usernameTextFiled:MKTextField = self.view.viewWithTag(1000) as! MKTextField
        let passwordTextFiled:MKTextField = self.view.viewWithTag(1001) as! MKTextField
        
        if(usernameTextFiled.text == ""){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: "Please enter valid email id and password.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else if(passwordTextFiled.text == ""){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: "Please enter valid email id and password.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }else{
            
            loginServiceCall(usernameTextFiled.text, password:passwordTextFiled.text)
            
        }
       
    }
    
    
   /* @IBAction func ForgotPassWordButtonClick(sender: AnyObject){
                    //Current Code, default colour is black
         //   let AccountForgotPasswordViewController:UIViewController = UIViewController()
         //   self.presentViewController(AccountForgotPasswordViewController, animated: true, completion: nil)
             self.performSegueWithIdentifier("logintoperformsegue", sender: self)
      
        
    }
    */
    

    func loginServiceCall(username:NSString, password:NSString){
            
            
        let params = ["username": "\(username)","password": "\(password)","method":"\(GlobalVariables.RequestAPIMethods.LoginCheck.rawValue as String)"]
        
        
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
                
                if let resultDictionary: Dictionary<String, AnyObject> = jsonDictionary["result"] as?  Dictionary<String, AnyObject> {
                    
                   // if let roleDictionary: Dictionary<String, AnyObject> = resultDictionary["role"] as?  Dictionary<String, AnyObject> {
                        
                    
                    

                    if let objectId:NSString = resultDictionary["objectId"] as? NSString {
                        
                        GlobalSettings.updateUserIdDefaultValue(objectId)
                        
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
    
    @IBAction func createacount(sender: AnyObject) {
        
        self.performSegueWithIdentifier("LoginViewToRegisterViewSegue", sender: self)
        
    }
    @IBAction func forgotPasswordButtonClick(sender: AnyObject) {
        
        self.performSegueWithIdentifier("LoginViewToForgotPasswordViewSegue", sender: self)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

};

