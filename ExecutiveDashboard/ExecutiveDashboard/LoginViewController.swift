//
//  LoginViewController.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 6/10/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit

enum ControlTags: Int {
    
    // enumeration definition goes here
    case kUsernameTextFiledTag = 2000
    case kPasswordTextFiledTag = 2001
    case kRememberCheckboxButtonTag = 2002
}

class LoginViewController: BaseViewController  {

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

       
        navigate()
    }
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = true
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

    func navigate(){
        
        
        var signedIn:Bool = GlobalVariables.globalUserDefaults.boolForKey(GlobalVariables.user_defaults_signed_in_key)
        var remember:Bool = GlobalVariables.globalUserDefaults.boolForKey(GlobalVariables.user_defaults_remember_me_key)
        
        if(signedIn&&remember){
            
            var username : NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_username_key) as! NSString
            var password : NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_password_key) as! NSString
            
            let jsonString:NSString = "{\"username\":\"\(username)\",\"password\":\"\(password)\"}";
            
            
            NetworkManager.loginCheckServiceCall("Login", bodyData: jsonString, viewController:self)
            
        }
        
    }

    // MARK: - Button click methods
    @IBAction func rememberMeButtonClick(sender: UIButton) {
    
        let checkboxImage = UIImage(named: "check_box.png") as UIImage!
        let normalImage = UIImage(named: "normal_box.png") as UIImage!

        
        var rememberMeCheckboxButton : UIButton = self.view.viewWithTag(Int(ControlTags.kRememberCheckboxButtonTag.rawValue)) as! UIButton
        
        if(rememberMeCheckboxButton.selected){
            
            rememberMeCheckboxButton.setImage(normalImage, forState: .Normal)
            rememberMeCheckboxButton.selected = false
            
            //Update user default value
            GlobalSettings.updateRemeberMeDefaultValue(false)

        
        }else{
        
            var usernameTextField : UITextField = self.view.viewWithTag(Int(ControlTags.kUsernameTextFiledTag.rawValue)) as! UITextField
            var passwordTextField : UITextField = self.view.viewWithTag(Int(ControlTags.kPasswordTextFiledTag.rawValue)) as! UITextField

            rememberMeCheckboxButton.setImage(checkboxImage, forState: .Normal)
            rememberMeCheckboxButton.selected = true

            //Update user default value
            GlobalSettings.updateRemeberMeDefaultValue(true)
            
            GlobalSettings.updateUsernameDefaultValue(usernameTextField.text)
            GlobalSettings.updatePasswordDefaultValue(passwordTextField.text)
            
        }
        
    
    }
    @IBAction func signinButtonClick(sender: UIButton) {
        
        var usernameTextField : UITextField = self.view.viewWithTag(Int(ControlTags.kUsernameTextFiledTag.rawValue)) as! UITextField
        var passwordTextField : UITextField = self.view.viewWithTag(Int(ControlTags.kPasswordTextFiledTag.rawValue)) as! UITextField

        if(usernameTextField.text == ""||usernameTextField.text == nil){
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please username."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }else if(passwordTextField.text == ""||passwordTextField.text == nil){
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please enter password."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }else{
            
            let jsonString:NSString = "{\"username\":\"\(usernameTextField.text)\",\"password\":\"\(passwordTextField.text)\"}";

            NetworkManager.loginCheckServiceCall(GlobalVariables.RequestAPIMethods.Login.rawValue, bodyData: jsonString, viewController: self)

        }
    
    }
 
}
