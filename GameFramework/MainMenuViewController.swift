//
//  MainMenuViewController.swift
//  GameFramework
//
//  Created by apple on 4/27/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit

class MainMenuViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = true
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
    @IBAction func scoreboardButtonClick(sender: UIButton) {
        
    }
    @IBAction func statisticsButtonClick(sender: UIButton) {
        
    }
    @IBAction func settingsButtonClick(sender: UIButton) {
        
    }
    @IBAction func tutorialButtonClick(sender: UIButton) {
        
    }
    @IBAction func aboutusButtonClick(sender: UIButton) {
        
    }
}
