//
//  MainSearchViewController.swift
//  HTI
//
//  Created by Training on 8/28/15.
//
//

import UIKit
import QuartzCore
import MaterialKit
import AFNetworking
import MBProgressHUD

let CITY_PICKER_VIEW_TAG = 2000
let COURSE_PICKER_VIEW_TAG = 2001


class MainSearchViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak private var citynameTextFiled:MKTextField!
    @IBOutlet weak private var coursenameTextFiled:MKTextField!
    
    // returns the number of 'columns' to display.
    var pickerView: UIPickerView!
    var cityArray:NSArray!
    var courseArray:NSArray!
    var selectedRow:Int = 0
    var delegate: CenterViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.cityArray = NSArray()
        self.cityArray = SetupDataModel.getAllCities() as NSArray

        
        self.courseArray=NSMutableArray()
        self.courseArray = SetupDataModel.getAllCourses() as NSArray
        
        self.setControlProperties()
        
    }
    
    func textFieldShouldBeginEditing(textField: MKTextField) -> Bool {
        
        let citynameTextFiled:MKTextField = self.view.viewWithTag(1005) as! MKTextField
        
        let coursenameTextFiled:MKTextField = self.view.viewWithTag(1006) as! MKTextField
        
        if (textField == citynameTextFiled)  {
            
        } else{
            
        }
    
        
        return false
    }
    
    
     func setControlProperties(){
        
        // No border, no shadow, floatingPlaceholderEnabled
        citynameTextFiled.layer.borderColor = UIColor.clearColor().CGColor
        citynameTextFiled.floatingPlaceholderEnabled = true
        citynameTextFiled.placeholder = "choose cityname"
        citynameTextFiled.tintColor = UIColor.MKColor.Green
        citynameTextFiled.rippleLocation = .Right
        citynameTextFiled.cornerRadius = 10
        citynameTextFiled.bottomBorderEnabled = true
       
        coursenameTextFiled.layer.borderColor = UIColor.clearColor().CGColor
        coursenameTextFiled.floatingPlaceholderEnabled = true
        coursenameTextFiled.placeholder = "select course"
        coursenameTextFiled.tintColor = UIColor.MKColor.Green
        coursenameTextFiled.rippleLocation = .Right
        coursenameTextFiled.cornerRadius = 10
        coursenameTextFiled.bottomBorderEnabled = true
        
        
        //Creating pickerview object
        self.pickerView = UIPickerView(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
     
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Button actions
    @IBAction func menuButtonClick(sender: AnyObject) {
        
        delegate?.toggleLeftPanel?()
    }
    
    @IBAction func showInstitutesButtonClick(sender: AnyObject) {
        
        let citynameTextFiled:MKTextField = self.view.viewWithTag(1005) as! MKTextField
        let coursenameTextFiled:MKTextField = self.view.viewWithTag(1006) as! MKTextField
        
        if (citynameTextFiled.text == "") {
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: "Enter your city ", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }else if (coursenameTextFiled.text == ""){
            
            var alert = UIAlertController(title:GlobalVariables.appName, message: "Please enter coursename", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }else{
          
             getAllClassDetails()

            
        }
             
    }
    @IBAction func classDetailsButtonClick(sender: AnyObject) {
        
        getAllClassDetails()
        
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

 
    @IBAction func cityButtonClick(sender: AnyObject) {
        
        self.pickerView.tag = CITY_PICKER_VIEW_TAG
        self.showPickerView()
        
    }
    
    @IBAction func courseButtonClick(sender: AnyObject) {
        
        self.pickerView.tag = COURSE_PICKER_VIEW_TAG
        self.showPickerView()
        
    }

  
    func showPickerView(){
        
        
        //Creating view to add datepicker
        var viewPicker: UIView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        viewPicker.backgroundColor = UIColor.clearColor()
              //Initializing date picker
       
        viewPicker.addSubview   (self.pickerView)
        
        
        let alertController = UIAlertController(title: GlobalVariables.appName, message:"\n\n\n\n\n\n\n\n\n", preferredStyle: .ActionSheet)
        alertController.view.addSubview(viewPicker)
        
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            
            // ...
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            
            if(self.pickerView.tag == CITY_PICKER_VIEW_TAG) {
                
                let citynameTextFiled:MKTextField = self.view.viewWithTag(1005) as! MKTextField
                
                let selectedRow = self.pickerView.selectedRowInComponent(0)
                
                if let cityDictionary:NSDictionary = self.cityArray[selectedRow] as? NSDictionary{
                    
                    citynameTextFiled.text = cityDictionary.valueForKey("name") as! String
                    
                    //Update userdefaults city object id
                    GlobalSettings.updateCityDefaultValue(cityDictionary.valueForKey("objectId") as! String)
                    
                }
                
               
                
            }else{
                
                let coursenameTextFiled:MKTextField = self.view.viewWithTag(1006) as! MKTextField
                
                let selectedRow = self.pickerView.selectedRowInComponent(0)
                
                if let courseDictionary:NSDictionary = self.courseArray[selectedRow] as? NSDictionary{
                    
                    coursenameTextFiled.text = courseDictionary.valueForKey("name") as! String

                    //Update userdefaults city object id
                    GlobalSettings.updateCourseDefaultValue(courseDictionary.valueForKey("objectId") as! String)
                    
                }
                
            }
            
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            
            // ...
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if (pickerView.tag == CITY_PICKER_VIEW_TAG){
            
            return cityArray.count
       
        }else{
            
            return courseArray.count
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if (pickerView.tag == CITY_PICKER_VIEW_TAG){
            
            var cityName = ""
            
            if let cityDictionary:NSDictionary = self.cityArray[row] as? NSDictionary{
                
                cityName = cityDictionary.valueForKey("name") as! String

            }
            
            return cityName
            
        }else{
            
            var courseName = ""

            if let courseDictionary:NSDictionary = self.courseArray[row] as? NSDictionary{
                
                courseName = courseDictionary.valueForKey("name") as! String
                
            }
            
            return courseName
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
   
}


