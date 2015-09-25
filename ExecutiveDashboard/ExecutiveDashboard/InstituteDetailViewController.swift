//
//  InstituteDetailViewController.swift
//  HTI
//
//  Created by Training on 8/29/15.
//
//

import UIKit
import QuartzCore
import MagicalRecord
import AFNetworking
import MBProgressHUD
import MaterialKit

enum TableViewEnum {
    
    case kCourses
    case kTrainers
    case kComments
}

let NAME_LABLE_VIEW_TAG = 2

class InstituteDetailViewController: UIViewController {
    
    @IBOutlet weak private var listTableView: UITableView!
    @IBOutlet weak private var scrollView:UIScrollView!
    @IBOutlet var floatingPlusButton: MKButton!
    
    var currentTableView:TableViewEnum = TableViewEnum.kCourses
    var classDetailObject:NSManagedObject!
    var instituteDetailsDictionary:NSDictionary!
    var trainersArray:NSArray!
    var commentsArray:NSArray!
    var classDetailsArray:NSArray!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.trainersArray = NSArray()
        self.commentsArray = NSArray()
        self.classDetailsArray = NSArray()
        self.instituteDetailsDictionary = NSDictionary()

        self.automaticallyAdjustsScrollViewInsets = false
        scrollView.contentSize = CGSizeMake(self.view.bounds.width, 1330)
        
        self.listTableView.rowHeight = 88

        
        //Setting button properties
        self.floatingPlusButton.cornerRadius = 40.0
        self.floatingPlusButton.backgroundLayerCornerRadius = 40.0
        self.floatingPlusButton.maskEnabled = false
        self.floatingPlusButton.ripplePercent = 1.75
        self.floatingPlusButton.rippleLocation = .Center
        
        self.floatingPlusButton.layer.shadowOpacity = 0.75
        self.floatingPlusButton.layer.shadowRadius = 3.5
        self.floatingPlusButton.layer.shadowColor = UIColor.blackColor().CGColor
        self.floatingPlusButton.layer.shadowOffset = CGSize(width: 1.0, height: 5.5)
        
       
        //Refresh the view
        self.refreshView()
        
        self.getInstituteDetailsServiceCall()
        
        
    }
    func refreshView(){
        
        
        
        if let instituteNameLabel : UILabel = self.view.viewWithTag(9) as? UILabel{
            
            if let instituteNameObject:NSDictionary = self.classDetailObject.valueForKey("instituteDetail") as? NSDictionary{
                
                instituteNameLabel.text = instituteNameObject.valueForKey("name") as? String
                
            }
        }
        
        if let cityTypeLabel : UILabel = self.view.viewWithTag(21) as? UILabel{
            
            
            if let cityObject:NSDictionary = self.classDetailObject.valueForKey("city") as? NSDictionary{
                
                cityTypeLabel.text = cityObject.valueForKey("name") as? String
                
            }
            
        }
        
        //Set objects values
        self.trainersArray = InstituteDetailsModel.getAllTrainers() as NSArray
        self.commentsArray = InstituteDetailsModel.getAllComments() as NSArray
        self.classDetailsArray = InstituteDetailsModel.getAllClassDetails() as NSArray
        
        self.listTableView.reloadData()

    }
    
    func getInstituteDetailsServiceCall(){
        
        
        let manager = NetworkManager.initAFNetworkManager()
        
        var instituteDetailsId = ""
            
        if let instituteDetailsDictionary:NSDictionary = self.classDetailObject.valueForKey("instituteDetail") as? NSDictionary{
                
            instituteDetailsId = instituteDetailsDictionary.valueForKey("objectId") as! String
            
        }

    
        let params = ["instituteDetailId":"\(instituteDetailsId)","method":"\(GlobalVariables.RequestAPIMethods.GetInstituteDetails.rawValue as String)"]
        
        //Show the progress bard
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        progressHUD.labelText = "Loading..."
        
        
        manager.POST(GlobalVariables.request_url ,parameters: params,
            
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                //Hide progress bar
                progressHUD.hide(true)
                println(responseObject.description)
                
                InstituteDetailsModel.deleteAllObjects()
                
                let jsonDictionary = responseObject as! Dictionary<String, AnyObject>
                
                InstituteDetailsModel.initWithDictionary(jsonDictionary)
                
                
                self.refreshView()
                
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    @IBAction func segmentValueChanged(sender: AnyObject) {
        
        let segmentController:UISegmentedControl = sender as! UISegmentedControl
        
        let selectedIndex = segmentController.selectedSegmentIndex
        
        switch selectedIndex {
            
        case 0:
            
            currentTableView = TableViewEnum.kCourses
            
        case 1:
            
            currentTableView = TableViewEnum.kComments

        default:
            
            currentTableView = TableViewEnum.kTrainers

        }
        
        self.refreshView()
    }

    
}
extension InstituteDetailViewController:UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRows = 0
        
        switch (currentTableView) {
            
        case .kCourses:
            
            numberOfRows = self.classDetailsArray.count
            
        case .kComments:
            
            numberOfRows = self.commentsArray.count
            
        default:
            
            numberOfRows = self.trainersArray.count
            
            break
        }
        return numberOfRows
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        
        switch (currentTableView) {
            
        case .kCourses:
            
            cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
            
            let cardView:UIView = cell.contentView.viewWithTag(1000) as UIView!
            self.setupCellCardView(cardView)
            
            if let nameLable : UILabel = cardView.viewWithTag(NAME_LABLE_VIEW_TAG) as? UILabel{
                
                if let dictionary:NSDictionary = self.classDetailsArray.objectAtIndex(indexPath.row) as? NSDictionary {
                
                    if let courseDictionary:NSDictionary = dictionary.valueForKey("course") as? NSDictionary {
                        
                        nameLable.text = courseDictionary.valueForKey("name") as? String
                    }
                    
                }
            }
            
        case .kComments:
            
            cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
            
            let cardView:UIView = cell.contentView.viewWithTag(1000) as UIView!
            self.setupCellCardView(cardView)
            
            if let nameLable : UILabel = cardView.viewWithTag(NAME_LABLE_VIEW_TAG) as? UILabel{
                
                if let dictionary:NSDictionary = self.commentsArray.objectAtIndex(indexPath.row) as? NSDictionary {
                    
                    nameLable.text = dictionary.valueForKey("comment") as? String
                    
                }
            }
            
        default:
            
            cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
            
            let cardView:UIView = cell.contentView.viewWithTag(1000) as UIView!
            self.setupCellCardView(cardView)
            
            if let nameLable : UILabel = cardView.viewWithTag(NAME_LABLE_VIEW_TAG)as? UILabel{
                
                if let dictionary:NSDictionary = self.trainersArray.objectAtIndex(indexPath.row) as? NSDictionary {
                    
                    nameLable.text = dictionary.valueForKey("name") as? String
                    
                }
            }
            
            break
        }
        

        //Setup card view to the cell
        //let cardView:UIView = cell.contentView.viewWithTag(1000) as UIView!
        // self.setupCellCardView(cardView)
        
        
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        /*switch (currentTableView) {
        
        case .kCourses:
        
        
        case .kComments:
        
        
        default:
        
        
        break
        }*/
        
        
    }
    
    
}

