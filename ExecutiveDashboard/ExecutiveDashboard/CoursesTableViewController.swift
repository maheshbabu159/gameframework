//
//  CoursesTableViewController.swift
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


class CoursesTableViewController: UITableViewController {

    var delegate: CenterViewControllerDelegate?
    
    var  coursesArray:NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
       
        
       coursesArray = NSArray()
        
        coursesArray = SetupDataModel.getAllCourses()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAllClassDetails(){
        
        
        let manager = NetworkManager.initAFNetworkManager()
        
        var cityId:String = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_city_id_key) as! String
        
        var courseId:String = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_course_id_key)as! String
        
        let params = [  "courseId": "\(courseId)",
            "cityId": "\(cityId)","method":"\(GlobalVariables.RequestAPIMethods.GetAllClassDetailsByCityAndCourse.rawValue as String)"]
        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "Loading..."
        
        manager.POST(GlobalVariables.request_url ,parameters: params,
            
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                //Hide progress bar
                progressHUD.hide(true)
                println(responseObject.description)
                
                let jsonDictionary = responseObject as! Dictionary<String, AnyObject>
                
                ClassDetailsModel.deleteAllClassDetails()
                
                ClassDetailsModel.initWithDictionary(jsonDictionary)
                
            
                //changeing to the another slide bar
                let containerViewController = ContainerViewController()
                containerViewController.selectedIndex = 1
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window?.rootViewController = containerViewController

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


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.coursesArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        
        if let courseObject:NSDictionary =  coursesArray.objectAtIndex(indexPath.row) as? NSDictionary{
            
                       
            cell.textLabel!.text = courseObject.valueForKey("name") as? String
 
        }
     
        // Configure the cell...

        return cell
    }
    
      override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("You selected cell #\(indexPath.row)!")

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        
        if let courseObject:NSDictionary =  coursesArray.objectAtIndex(indexPath.row) as? NSDictionary{
            
            
            cell.textLabel!.text = courseObject.valueForKey("name") as? String
            
            GlobalSettings.updateCourseDefaultValue(courseObject.valueForKey("objectId") as! String)
            
            var courseId:String = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_course_id_key)as! String
            
            println(courseId)
            
            //self.performSegueWithIdentifier("CourseListToInstituteViewSegue", sender: self)
            
             getAllClassDetails()

        }
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Button actions
    @IBAction func menuButtonClick(sender: AnyObject) {
        
        delegate?.toggleLeftPanel?()
    }


}
