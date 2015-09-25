//
//  UserRegistrationViewController.swift
//  HTI
//
//  Created by Training on 8/10/15.
//
//

import UIKit
import AFNetworking
import MBProgressHUD


class UserRegistrationViewController:UIViewController{


    var pickerView: UIPickerView!
    var rolesArray:NSArray!
    var selectedRow:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.pickerView = UIPickerView(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        //self.pickerView.dataSource = self
        //self.pickerView.delegate = self
        rolesArray = NSArray()

        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        let roleIdTextFiled:UITextField = self.view.viewWithTag(16) as! UITextField

        if(textField==roleIdTextFiled){

        }

        return false
    }
    @IBAction func submitButtonClick(sender: UIButton) {
        
        let usernameTextFiled:UITextField = self.view.viewWithTag(10) as! UITextField
        let firstNameTextFiled:UITextField = self.view.viewWithTag(11) as! UITextField
        let LastNameTextFiled:UITextField = self.view.viewWithTag(12) as! UITextField
        let EmailTextFiled:UITextField = self.view.viewWithTag(13) as! UITextField
        let PhoneNumberTextFiled:UITextField = self.view.viewWithTag(15) as! UITextField
        let ConfirmEmailTextFiled:UITextField = self.view.viewWithTag(14)as! UITextField
        let roleIdTextFiled:UITextField = self.view.viewWithTag(16) as! UITextField
        let passwordTextField:UITextField = self.view.viewWithTag(17) as! UITextField
        
        
        if(EmailTextFiled.text == ""){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: "Please enter valid email id.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }else if(PhoneNumberTextFiled.text == ""){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: "Please enter you phonenumber.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }else if(usernameTextFiled.text == ""){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: "Please enter username.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }
        else if(firstNameTextFiled.text == ""){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: "Please enter firstname.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }
        else if(LastNameTextFiled.text == ""){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: "Please enter lastname.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }
        else if(ConfirmEmailTextFiled.text == ""){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: "email id didn't match", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }
        else if(roleIdTextFiled.text == ""){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: "Please enter roleId.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }
        else if(passwordTextField.text == ""){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: "Please enter password.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }

        else{
           
            addUserServiceCall(usernameTextFiled.text,firstName:firstNameTextFiled.text,lastName:LastNameTextFiled.text,email:EmailTextFiled.text,confirmEmail:ConfirmEmailTextFiled.text,phoneNumber:PhoneNumberTextFiled.text,password:passwordTextField.text,roleId:roleIdTextFiled.text)
        }
        
    }

    @IBAction func rollButtonClick(sender:UIButton){
        

        getRolesServiceCall()
        
    }
    func getRolesServiceCall(){
        
        let manager = NetworkManager.initAFNetworkManager()
        
        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
        manager.POST(GlobalVariables.request_url + (GlobalVariables.RequestAPIMethods.GetRoles.rawValue as String),parameters: nil,
            
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                //Hide progress bar
                progressHUD.hide(true)
                println(responseObject.description)
                
                let jsonDictionary = responseObject as! Dictionary<String, AnyObject>
                
                if let resultArray:NSArray = jsonDictionary["result"] as? NSArray{
                    
                    self.rolesArray = resultArray

                }
                
                self.showPickerView()
                
                
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
    

    func showPickerView(){

        //Creating view to add datepicker
        var viewPicker: UIView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        viewPicker.backgroundColor = UIColor.clearColor()
        
        
        //Initializing date picker
        viewPicker.addSubview(self.pickerView)
        
        let alertController = UIAlertController(title: GlobalVariables.appName, message:"\n\n\n\n\n\n\n\n\n", preferredStyle: .ActionSheet)
        alertController.view.addSubview(viewPicker)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            
            // ...
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            
           
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            
            // ...
        }
 

    }
   
   func addUserServiceCall(username:NSString,firstName:NSString,lastName:NSString,email:NSString,confirmEmail:NSString,phoneNumber:NSString,password:NSString,roleId:NSString){
        
        var roleObjectId = ""

        if let dictionary:NSDictionary = rolesArray[selectedRow] as? NSDictionary{
        
            roleObjectId = dictionary.valueForKey("objectId") as! String
        }



        let params = ["username": "\(username)","PhoneNumber": "\(phoneNumber)",
            "firstName":"\(firstName)","lastName":"\(lastName)","email":"\(email)","password":"\(password)","roleId":"\(roleObjectId)"]
        
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
                
               // UserModel.deleteAllUsers()
                
                var alert = UIAlertController(title:GlobalVariables.appName, message: "user added successfully", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)

                
               /* self.performSegueWithIdentifier("registrationViewToCoursersListSegue", sender: self)*/
                
                
                
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
extension UserRegistrationViewController: UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(colorPicker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rolesArray.count
    }
}

extension UserRegistrationViewController: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        
        if let dictionary:NSDictionary = rolesArray[row] as? NSDictionary{
            
            return dictionary.valueForKey("name") as! String
            
        }else{
            
            return ""
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        if let dictionary:NSDictionary = rolesArray[row] as? NSDictionary{
            
            
            let roleIdTextFiled:UITextField = self.view.viewWithTag(16) as! UITextField
            roleIdTextFiled.text =   dictionary.valueForKey("name") as! String
            
            selectedRow = row
            
            
        }
        

    }
}
