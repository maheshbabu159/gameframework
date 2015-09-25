//
//  ForgotPasswordViewController.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 7/6/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
import MaterialKit

class ForgotPasswordViewController: UIViewController  {
    
    
    var delegate: CenterViewControllerDelegate?
    @IBOutlet weak var Enteremail: MKTextField!
    
    enum ControlTags: Int {
        
        // enumeration definition goes here
       // case kUsernameTextFiledTag = 1000
        case kEmailTextFiledTag = 1003
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
    @IBAction func cancelButtonClick(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func submitButtonClick(sender: AnyObject) {
        
        let emailTextFiled:MKTextField = self.view.viewWithTag(1003) as! MKTextField
        
        if(emailTextFiled.text == ""){
            
             var alert = UIAlertController(title:GlobalVariables.appName, message: "Please enter email id.", preferredStyle: UIAlertControllerStyle.Alert)
             alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
             self.presentViewController(alert, animated: true, completion: nil)
            
            }else{
                    
                    resetpassword()
                }
    }

    
    func resetpassword(){
        
        
        let emailTextFiled:MKTextField = self.view.viewWithTag(1003) as! MKTextField

        let params = ["email": "\(emailTextFiled.text)","method":"\(GlobalVariables.RequestAPIMethods.ResetPassword.rawValue as String)"]
        
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
                    
                    if(resultString.isEqualToString("Password send to email.")){
                        
                        //self.performSegueWithIdentifier("AccountLoginViewController", sender: self)
                        
                        //self.navigationController?.popViewControllerAnimated(true)
                        
                        if let navController = self.navigationController {
                            navController.popViewControllerAnimated(true)
                            
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

extension ForgotPasswordViewController : UITextFieldDelegate  {
    
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
