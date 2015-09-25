//
//  SettingsTableViewController.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 6/22/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit
import QuartzCore
import MaterialKit
import AFNetworking
import MBProgressHUD


class SettingsTableViewController: UITableViewController {
    
    
    var delegate: CenterViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Settings"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.navigationController?.navigationBarHidden = false
        
       

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
   
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        
            
        
     
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
  
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if (segue.identifier == "settingstoChangepasswordViewControllerSegue") {
            // pass data to next view
          
            let destinationViewController = segue.destinationViewController as! ChangePasswordViewController
            
        }
    
             //  destinationViewController.
                
    }*/
    
    // MARK: Button actions
    @IBAction func menuButtonClick(sender: AnyObject) {
        
        delegate?.toggleLeftPanel?()
    }
    
    
    @IBAction func changePasswordButtonClick(sender: AnyObject){
        
        
        var userId:String = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_user_id_key) as! String

 
        if(userId==""){
            
            let containerViewController = ContainerViewController()
            containerViewController.selectedIndex = 3
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = containerViewController

            
        }else{
       
            self.performSegueWithIdentifier("SettingsViewToChangePasswordSegue", sender: self)
        
        }
    
    }
}
