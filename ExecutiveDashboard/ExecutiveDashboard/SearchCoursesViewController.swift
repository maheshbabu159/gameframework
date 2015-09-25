//
//  SearchCoursesViewController.swift
//  HTI
//
//  Created by Training on 8/4/15.
//
//

import UIKit
import AFNetworking
import MBProgressHUD

class SearchCoursesViewController: UIViewController {

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

    
    // MARK: - Button Click Methods
    @IBAction func searchButtonClick(sender: UIButton) {
        
        if let searchTextFiled:UITextField = self.view.viewWithTag(1000) as? UITextField{
            
            if(searchTextFiled.text == ""){
                
                var alert = UIAlertController(title:GlobalVariables.appName, message: "Please enter course name.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
               
                
                
            }else{
                
                getAllUsers()
                
            }
            
        }
    }
    
    func getAllUsers(){
    
        
        let manager = NetworkManager.initAFNetworkManager()
        
        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
        manager.POST(GlobalVariables.request_url + (GlobalVariables.RequestAPIMethods.GetAllUsers.rawValue as String),parameters: nil,
            
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                //Hide progress bar
                progressHUD.hide(true)
                println(responseObject.description)
                
                let jsonDictionary = responseObject as! Dictionary<String, AnyObject>
                
                UserModel.deleteAllUsers()

                UserModel.initWithDictionary(jsonDictionary)

                self.performSegueWithIdentifier("SearchViewToCoursersListSegue", sender: self)
                
                
                
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

    @IBAction func facebookButtonClick(sender: UIButton) {
        
        self.performSegueWithIdentifier("searchToSigninSegue", sender: self)
    }
    
    @IBAction func googleButtonClick(sender: UIButton) {
        
        self.performSegueWithIdentifier("searchToSigninSegue", sender: self)
    }
    
    @IBAction func signupButtonClick(sender: UIButton) {
        
        self.performSegueWithIdentifier("searchToRegisterSegue", sender: self)
    }
    @IBAction func alreadyregisterButtonClick(sender: UIButton) {
        
        self.performSegueWithIdentifier("searchviewToSigninSegue", sender: self)
    }
}
