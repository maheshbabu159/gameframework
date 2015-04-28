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

class ScoreboardViewController: UIViewController {

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
              
                println("2001")
                
            default:
                
                println("none")
            }
            
        }

    }
    
    //MARK: Score update  methods
    func updateScores(enumValue : ButtonTags){
    
        var buttonTag : ButtonTags?
        
        buttonTag = enumValue

        if let buttonTag = buttonTag{
            
            switch (buttonTag) {
                
            case .kHomeTriesButtonTag:
                
                var button : UIButton = self.view.viewWithTag(Int(ButtonTags.kHomeTriesButtonTag.rawValue)) as UIButton

                button.setTitle("1", forState: UIControlState.Normal)
                
            case .kGuestTriesButtonTag:
                
                println("2001")
                
            default:
                
                println("none")
            }
            
        }

        
    }
   
}
