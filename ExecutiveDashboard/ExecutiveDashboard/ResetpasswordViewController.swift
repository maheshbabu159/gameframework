//
//  ResetpasswordViewController.swift
//  HTI
//
//  Created by Training on 8/5/15.
//
//

import UIKit

class ResetpasswordViewController: UIViewController {

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
    @IBAction func submitButtonClick(sender: UIButton){
    
    
    if let mail1TextFiled:UITextField = self.view.viewWithTag(1007) as? UITextField{
        
        if(mail1TextFiled.text == ""){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: "enter your email to reset password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{

              var alert = UIAlertController(title:GlobalVariables.appName, message: "A link has been send to your email to reset password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        
        self.performSegueWithIdentifier("resetToSigninSegue", sender: self)
        }


}

}

