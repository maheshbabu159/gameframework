//
//  LoginViewController.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 6/10/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

enum ControlTags: Int {
    
    // enumeration definition goes here
    case kUsernameTextFiledTag = 2000
    case kPasswordTextFiledTag = 2001
    case kRememberCheckboxButtonTag = 2002
}

enum PickerTypes: Int {
    
    // enumeration definition goes here
    case FromPicker = 0
    case ToPicker = 1
    
}


class LoginViewController: BaseViewController  {
    
    var datePicker: UIDatePicker!
    
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
            
            self.loginServiceCall(username,password: password)
            
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
            
            //Call login service
            self.loginServiceCall(usernameTextField.text,password: passwordTextField.text)
            
        }
      
        
    }
    
    // MARK: Login Service Call
    func loginServiceCall(username:NSString, password:NSString){
        
        
        let params = ["username": "\(username)","password": "\(password)"]
        
        let manager = NetworkManager.initAFNetworkManager()

        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
        manager.POST(GlobalVariables.request_url + (GlobalVariables.RequestAPIMethods.Login.rawValue as String),parameters: params,
        
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                //Hide progress bar
                progressHUD.hide(true)
                println(responseObject.description)
                
                let jsonDictionary = responseObject as! Dictionary<String, AnyObject>
                
                //return (true, rootDictionary)
                
                if let resultString:NSString = jsonDictionary["result"] as? NSString {
                    
                    println(resultString)
                    
                    if(resultString.isEqualToString("Invalid Credentials")){
                        
                        let alertController = UIAlertController(title:"Executive Dashboard", message:resultString as String
                            , preferredStyle: UIAlertControllerStyle.Alert)
                        
                        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
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
                                
                                self.showDatePickerInAlert(0, title: "From Date")

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
    
    func showDatePickerInAlert(tag:Int, title:NSString){
        
        //Creating view to add datepicker
        var viewDatePicker: UIView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        viewDatePicker.backgroundColor = UIColor.clearColor()
        
        
        //Initializing date picker
        self.datePicker = UIDatePicker(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        self.datePicker.datePickerMode = UIDatePickerMode.Date
        self.datePicker.addTarget(self, action: nil, forControlEvents: UIControlEvents.ValueChanged)
        
        
        viewDatePicker.addSubview(self.datePicker)
        
        let alertController = UIAlertController(title: title as String, message:"\n\n\n\n\n\n\n\n\n", preferredStyle: .ActionSheet)
        alertController.view.addSubview(viewDatePicker)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            
            // ...
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            
            if(tag == 0){
                
                self.dateSelected(0)

            }else{
                
                self.dateSelected(1)
            }
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            
            // ...
        }

    }

    func dateSelected(tag:Int)
    {
        var selectedDate:NSString =  self.dateformatterDateTime(datePicker.date)
        
        println(selectedDate)
        
        let range = NSRange(location:0, length:2)
        
        var month:NSString = selectedDate.substringWithRange(NSRange(location:0, length:2))
        
        var year:NSString = selectedDate.substringWithRange(NSRange(location:4, length:4))
        
        
        switch tag {
            
        case PickerTypes.FromPicker.rawValue:
            
            GlobalSettings.updateFromMonthDefaultValue(month.integerValue)
            GlobalSettings.updateFromYearDefaultValue(year.integerValue)
            
            //Show the pickerview
            self.showDatePickerInAlert(1, title:"To Date")

        default:
            
            GlobalSettings.updateToMonthDefaultValue(month.integerValue)
            GlobalSettings.updateToYearDefaultValue(year.integerValue)
            
          
            
            
            var sessionId:NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_session_id_key) as! NSString
            let jsonString:NSString = "{\"sessionId\":\"\(sessionId)\"}"
            //Send registration request
            NetworkManager.registerDeviceServiceCall("RegisterDevice", bodyData: jsonString, viewController: self)

        }
        
    }
    
    
    func dateformatterDateTime(date: NSDate) -> NSString
    {
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMddyyyy"
        return dateFormatter.stringFromDate(date)
        
        
        
    }
    func datePickerSelected(sender: UIDatePicker) {
        
        
        
        
        
        
    }
}
extension LoginViewController : UITextFieldDelegate  {
    
    // MARK: - Textfiled delegate methods
    func textFieldDidBeginEditing(textField: UITextField) {    //delegate method
        
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {  //delegate method
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        
        textField.resignFirstResponder()
        
        return true
    }
    
}