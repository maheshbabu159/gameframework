//
//  ChangePasswordViewController.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 7/6/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
import MaterialKit



class ChangePasswordViewController: UIViewController {
    var delegate: CenterViewControllerDelegate?
    
    @IBOutlet weak var oldPasswordTextField: MKTextField!
    @IBOutlet weak var newPasswordTextField: MKTextField!
    
    enum ControlTags: Int {
       
        // enumeration definition goes here
       // case kOldPasswordTextFiledTag = 3000
        //case kNewPasswordTextFiledTag = 3001
        case kConfirmPasswordTextFiledTag = 1002
    }
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
    // MARK: Button actions
    @IBAction func menuButtonClick(sender: AnyObject) {
        
        delegate?.toggleLeftPanel?()
    }
  
  @IBAction func confirmButtonClick(sender: AnyObject) {

         let oldPasswordTextField:MKTextField = self.view.viewWithTag(3000) as! MKTextField
         let newPasswordTextField:MKTextField = self.view.viewWithTag(3001) as! MKTextField
    

        //let oldPassworTextField : UITextField = self.view.viewWithTag(Int(ControlTags.kOldPasswordTextFiledTag.rawValue))as! UITextField
        //let newPasswordTextField : UITextField = self.view.viewWithTag(Int(ControlTags.kNewPasswordTextFiledTag.rawValue)) as! UITextField
        //let confirmPasswordTextField : UITextField = self.view.viewWithTag(Int(ControlTags.kConfirmPasswordTextFiledTag.rawValue)) as! UITextField

 
        
        if(oldPasswordTextField.text == ""||oldPasswordTextField.text == nil){
            
                let alertController = UIAlertController(title:"Executive Dashboard", message:"Please enter old password."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
                self.presentViewController(alertController, animated: true, completion: nil)

            }else if(newPasswordTextField.text == ""||newPasswordTextField.text == nil){
            
                 let alertController = UIAlertController(title:"Executive Dashboard", message:"Please enter new password."
                      , preferredStyle: UIAlertControllerStyle.Alert)
            
                 alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
                self.presentViewController(alertController, animated: true, completion: nil)
            
        }
       /* else if(confirmPasswordTextField.text == ""||confirmPasswordTextField.text == nil){
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Please enter confirm password."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }else if(!(newPassword.isEqualToString(confirmPasswordTextField.text))){
            
            let alertController = UIAlertController(title:"Executive Dashboard", message:"Passwords does not match. Please enter again."
                , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }*/
        else{
            
            changePassword()
            
        }

    }
    
    func changePassword(){
        
        
        let oldPasswordTextField:MKTextField = self.view.viewWithTag(3000) as! MKTextField
        let newPasswordTextField:MKTextField = self.view.viewWithTag(3001) as! MKTextField
      
        var userId:String = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_user_id_key) as! String
        
       
        let params = ["userId": "\(userId)","oldPassword": "\(oldPasswordTextField.text)","password": "\(newPasswordTextField.text)","method":"\(GlobalVariables.RequestAPIMethods.ChangePassword.rawValue as String)"]
        
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
                    
                    
                    if(resultString.isEqualToString("Password changed successfully.")){
                        
                        //self.performSegueWithIdentifier("AccountLoginViewController", sender: self)
                        
                        //self.navigationController?.popViewControllerAnimated(true)
                        
                        
//                        if let navController = self.navigationController {
//                            navController.popViewControllerAnimated(true)
//                            
//                        }
                        let containerViewController = ContainerViewController()
                        containerViewController.selectedIndex = 3
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDelegate.window?.rootViewController = containerViewController
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


extension ChangePasswordViewController : UITextFieldDelegate  {
    
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


