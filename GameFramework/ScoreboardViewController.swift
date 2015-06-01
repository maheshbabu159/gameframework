//
//  ScoreboardViewController.swift
//  GameFramework
//
//  Created by apple on 4/27/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit

let kButtonStartingTagt:Int = 2000

var kButtonEndingTag: Int = 2009

enum ButtonTags: Int {
   
    // enumeration definition goes here
    case kHomeTriesButtonTag = 2000
    case kGuestTriesButtonTag = 2001

}

enum BBPhoto1: Int {
    case kommunen = 10
    case sagsbehandler = 20
    case festen = 30
}

class ScoreboardViewController: BaseViewController,UIPickerViewDataSource, UIPickerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = true
        
        
        //Adding target progamatically for a button
        for var index = kButtonStartingTagt; index < kButtonEndingTag; ++index {
            
            var button : UIButton = self.view.viewWithTag(index) as UIButton
            
            button.addTarget(self, action: "commonButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)

        }
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:Picker view delegate methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 3
    }
    
    func pickerView(pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
            
            return 2
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int,orComponent component: Int) -> String!{
        
        return "nssdf"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Button click methods
    @IBAction func commonButtonClick(sender: UIButton) {
        
        
        var buttonTag : ButtonTags?
        
        buttonTag = ButtonTags(rawValue: (sender as UIButton).tag)!
        
        if let buttonTag = buttonTag{
            
            switch (buttonTag) {
                
            case .kHomeTriesButtonTag:
                
                updateScores(ButtonTags.kHomeTriesButtonTag)
                
            case .kGuestTriesButtonTag:
              
                updateScores(ButtonTags.kGuestTriesButtonTag)
                
            default:
                
                println("none")
            }
            
        }

    }
    @IBAction func saveButtonClick(sender:UIButton){
        
        
        MatchEntityModel.saveMatchToDatabase(GlobalSingleton.sharedInstance.getRootMatch())
        //showPickerInActionSheet("asf")
        
    }
    //MARK: Pickert view delegate methods
    func showPickerInActionSheet(sentBy: String) {
        
        var title = ""
        var message = "\n\n\n\n\n\n\n\n\n\n";
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.ActionSheet);
        alert.modalInPopover = true;
        
        
        //Create a frame (placeholder/wrapper) for the picker and then create the picker
        var pickerFrame: CGRect = CGRectMake(17, 52, 270, 100); // CGRectMake(left), top, width, height) - left and top are like margins
        var picker: UIPickerView = UIPickerView(frame: pickerFrame);
        
        
        if(sentBy == ""){
            picker.tag = 1;
        } else if (sentBy == "user"){
            picker.tag = 2;
        } else {
            picker.tag = 0;
        }
        
        
        //Add the picker to the alert controller
        alert.view.addSubview(picker);
        
        //Create the toolbar view - the view witch will hold our 2 buttons
        var toolFrame = CGRectMake(17, 5, 270, 45);
        var toolView: UIView = UIView(frame: toolFrame);
        
        //add buttons to the view
        var buttonCancelFrame: CGRect = CGRectMake(0, 7, 100, 30); //size & position of the button as placed on the toolView
        
        //Create the cancel button & set its title
        var buttonCancel: UIButton = UIButton(frame: buttonCancelFrame);
        buttonCancel.setTitle("Cancel", forState: UIControlState.Normal);
        buttonCancel.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
        toolView.addSubview(buttonCancel); //add it to the toolView
        
        //Add the target - target, function to call, the event witch will trigger the function call
        buttonCancel.addTarget(self, action: "cancelSelection:", forControlEvents: UIControlEvents.TouchDown);
        
        
        //add buttons to the view
        var buttonOkFrame: CGRect = CGRectMake(170, 7, 100, 30); //size & position of the button as placed on the toolView
        
        //Create the Select button & set the title
        var buttonOk: UIButton = UIButton(frame: buttonOkFrame);
        buttonOk.setTitle("Select", forState: UIControlState.Normal);
        buttonOk.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
        toolView.addSubview(buttonOk); //add to the subview
        
        //Add the tartget. In my case I dynamicly set the target of the select button
        if(sentBy == "profile"){
            buttonOk.addTarget(self, action: "saveProfile:", forControlEvents: UIControlEvents.TouchDown);
        } else if (sentBy == "user"){
            buttonOk.addTarget(self, action: "saveUser:", forControlEvents: UIControlEvents.TouchDown);
        }
        
        //add the toolbar to the alert controller
        alert.view.addSubview(toolView);
        
        self.presentViewController(alert, animated: true, completion: nil);
    }
    

    
    //MARK: Score update  methods
    func updateScores(enumValue : ButtonTags){
    
        var buttonTag : ButtonTags?
        
        buttonTag = enumValue

        if let buttonTag = buttonTag{
            
            switch (buttonTag) {
                
            case .kHomeTriesButtonTag:
                
                var button : UIButton = self.view.viewWithTag(Int(ButtonTags.kHomeTriesButtonTag.rawValue)) as UIButton
                
                GlobalSingleton.sharedInstance.getRootMatch().home_team_tries = GlobalSingleton.sharedInstance.getRootMatch().home_team_tries + 1
                
                button.setTitle("\( GlobalSingleton.sharedInstance.getRootMatch().home_team_tries)", forState: UIControlState.Normal)
                
            case .kGuestTriesButtonTag:
                
                var button : UIButton = self.view.viewWithTag(Int(ButtonTags.kGuestTriesButtonTag.rawValue)) as UIButton
                
                GlobalSingleton.sharedInstance.getRootMatch().guest_team_tries = GlobalSingleton.sharedInstance.getRootMatch().guest_team_tries + 1
                
                button.setTitle("\( GlobalSingleton.sharedInstance.getRootMatch().guest_team_tries)", forState: UIControlState.Normal)
                
            default:
                
                println("none")
            }
            
        }

        
        func saveProfile(sender: UIButton){
            // Your code when select button is tapped
            
        }
        
        func saveUser(sender: UIButton){
            // Your code when select button is tapped
        }
        
        func cancelSelection(sender: UIButton){
            println("Cancel");
            self.dismissViewControllerAnimated(true, completion: nil);
            // We dismiss the alert. Here you can add your additional code to execute when cancel is pressed
        }
        
        
        
        
        
    }
   
}
