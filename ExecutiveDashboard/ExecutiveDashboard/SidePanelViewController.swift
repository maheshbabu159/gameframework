//
//  LeftViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit

@objc
protocol DetailsViewControllerDelegate {
    
    func animalSelected(animal: MenuItem)
}
protocol ContainerViewControllerDelegate {
    
    func replaceDetailsViewController(row:NSInteger)
}

class SidePanelViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
   
    var detailsViewDelegate: DetailsViewControllerDelegate?
    var containerViewDelegate: ContainerViewControllerDelegate?

    var menuItemsArray: Array<MenuItem>!
    
    struct TableView {
        
        struct CellIdentifiers {
          
            static let AnimalCell = "AnimalCell"
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        //Set the profile values
        setProfileDetails()
        
        
        tableView.reloadData()
    }
    func setProfileDetails(){
        
        let profileView:UIView = self.tableView.viewWithTag(5000) as UIView!
        //profileView.backgroundColor = UIColor.darkGrayColor()
        profileView.layer.borderWidth = 2
        profileView.layer.borderColor = GlobalSettings.RGBColor(GlobalVariables.yellow_color).CGColor
        
        
        let profileNameLable:UILabel = profileView.viewWithTag(5010) as! UILabel!
        let profileImageView:UIImageView = profileView.viewWithTag(5011) as! UIImageView!
        
        profileImageView.clipsToBounds = true;
        profileImageView.layer.cornerRadius = 30;

        
        let profilesArray:NSArray = ProfileModel.getAllProfileObjects()
        let count = profilesArray.count
        
        if count > 0 {
            
            if let profile:Profile = profilesArray[0] as? Profile{
                
                profileNameLable.text = profile.firstname;
                
                let url = NSURL(string: profile.photo_url)
                let data = NSData(contentsOfURL: url!)
                
                profileImageView.image =  UIImage(data: data!)
            }
        }
        
    }
    @IBAction func logoutButtonClick(sender: AnyObject) {
        
        var sessionId:NSString = GlobalVariables.globalUserDefaults.valueForKey(GlobalVariables.user_defaults_session_id_key) as! NSString
        let jsonString:NSString = "{\"sessionId\":\"\(sessionId)\"}"
        
        var aPersonDictionary = ["sessionId":"\(sessionId)"]
        var bytes = NSJSONSerialization.dataWithJSONObject(aPersonDictionary, options: NSJSONWritingOptions.allZeros, error: nil)
        let resstr = NSString(data:bytes!, encoding: NSUTF8StringEncoding)
        
        NetworkManager.logoutDataServiceCall("Logout", bodyData: resstr!, viewController: self)
        
    }
}

// MARK: Table View Data Source

extension SidePanelViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuItemsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(TableView.CellIdentifiers.AnimalCell, forIndexPath: indexPath)as! AnimalCell
        tableView.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor.clearColor()
        cell.contentView.backgroundColor = UIColor.clearColor()
        cell.configureForAnimal(menuItemsArray[indexPath.row])
        return cell
    }
    
}

// Mark: Table View Delegate

extension SidePanelViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //let selectedAnimal = animals[indexPath.row]
        //sliderDelegate?.animalSelected(selectedAnimal)
        containerViewDelegate?.replaceDetailsViewController(indexPath.row)
    }
    
}

class AnimalCell: UITableViewCell {
    
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var imageCreatorLabel: UILabel!
    
    func configureForAnimal(animal: MenuItem) {
        
        animalImageView.image = animal.image
        imageNameLabel.text = animal.title
        //imageCreatorLabel.text = animal.creator
    }
    
}