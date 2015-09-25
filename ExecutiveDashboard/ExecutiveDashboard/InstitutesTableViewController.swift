//
//  InstitutesTableViewController.swift
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



let COURSE_VIEW_TAG = 8
let COURSENAME_VIEW_TAG = 3
let INSTITUTENAME_VIEW_TAG=4
let PHONENUMBER_VIEW_Tag=5
let DATE_VIEW_TAG=101
let TYPE_VIEW_TAG=102
let ADSRESS_VIEW_TAG=103



class InstitutesTableViewController: UITableViewController {
  
    var classDetailArray:NSArray!

    var delegate: CenterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // getAllClassDetails()
        
        classDetailArray = NSArray()
        
        classDetailArray = ClassDetailsModel.getAllClassobjects()
        
        
        //Setup cell cardview
    
    }
    func setupCellCardView(cardView:UIView){
        
        cardView.alpha =  1
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 1 // if you like rounded corners
        cardView.layer.shadowOffset = CGSizeMake(2, 2)
        cardView.layer.shadowRadius = 1
        cardView.layer.shadowOpacity = 0.2
       
        var path = UIBezierPath(rect: cardView.bounds)
        cardView.layer.shadowPath = path.CGPath;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   

  /* func getAllClassDetails(){
        
        
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
        
    }*/
    


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return self.classDetailArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        //Setup card view to the cell
        let cardView:UIView = cell.contentView.viewWithTag(1000) as UIView!
        self.setupCellCardView(cardView)
        
        if let classDetailsObject:NSManagedObject = classDetailArray[indexPath.row] as? NSManagedObject {
            
            if let instituteNameLabel : UILabel = cardView.viewWithTag(4) as? UILabel{
                
                
                if let instituteNameObject:NSDictionary = classDetailsObject.valueForKey("instituteDetail") as? NSDictionary{
                    
                    instituteNameLabel.text = instituteNameObject.valueForKey("name") as? String
                    
                    
                }
            }
            if let courseNameLabel : UILabel = cardView.viewWithTag(3) as? UILabel{
                
                if let courseObject:NSDictionary = classDetailsObject.valueForKey("course") as? NSDictionary{
                    
                    courseNameLabel.text = courseObject.valueForKey("name") as? String
                    
                }
                
            }
            if let classTypeLabel : UILabel = cardView.viewWithTag(6) as? UILabel{
                
                if let classTypeObject:NSDictionary = classDetailsObject.valueForKey("classType") as? NSDictionary{
                    
                    classTypeLabel.text = classTypeObject.valueForKey("name") as? String
                    
                }
                
                
            }
            if let cityTypeLabel : UILabel = cardView.viewWithTag(7) as? UILabel{
                
                
                if let cityObject:NSDictionary = classDetailsObject.valueForKey("city") as? NSDictionary{
                    
                    cityTypeLabel.text = cityObject.valueForKey("name") as? String
                    
                }
                
            }
            
            if let courseLabel : UILabel = cardView.viewWithTag(8) as? UILabel{
                
                
                if let courseObject1:NSDictionary = classDetailsObject.valueForKey("course") as? NSDictionary{
                    
                    courseLabel.text = courseObject1.valueForKey("name") as? String
                    
                }
                
            }
            
        }
                
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
    }*/
    
     override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
                 
         self.performSegueWithIdentifier("InstitutesListToDetailsViewSegue", sender: self)
   }
       
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if(segue.identifier == "InstitutesListToDetailsViewSegue"){
            
             let indexpath = self.tableView.indexPathForSelectedRow()
            
            let classDetailsObject:NSManagedObject = classDetailArray[indexpath!.row] as! NSManagedObject
            
            let destinationViewController:InstituteDetailViewController = segue.destinationViewController as! InstituteDetailViewController
            
            destinationViewController.classDetailObject = classDetailsObject
            
        }
        
    }
    
      // MARK: Button actions
    
    @IBAction func menuButtonClick(sender: AnyObject) {
        
        delegate?.toggleLeftPanel?()
    }

}

