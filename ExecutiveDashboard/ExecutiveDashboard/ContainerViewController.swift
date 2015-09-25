//
//  ContainerViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    
    case BothCollapsed
    case LeftPanelExpanded
    case RightPanelExpanded
}

enum DetailsViewController {
    
    case MainSearchViewController
    case InstitutesTableViewController
    case CoursesTableViewController
    case AccountViewController
    case SettingsViewController
    case HelpTableViewController
    
}




class ContainerViewController: UIViewController {
    
    var centerNavigationController: UINavigationController!
    var selectedIndex = 0
    
    var currentState: SlideOutState = .BothCollapsed {
        
        didSet {
           
            let shouldShowShadow = currentState != .BothCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    
    var menuSliderViewController: SidePanelViewController?
    
    let centerPanelExpandedOffset: CGFloat = 60
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(selectedIndex == 0){
            
            addDetailsViewContoller(DetailsViewController.MainSearchViewController)

        }else if(selectedIndex == 1){
            
            addDetailsViewContoller(DetailsViewController.InstitutesTableViewController)

            
        }else if(selectedIndex == 2){
            
            addDetailsViewContoller(DetailsViewController.CoursesTableViewController)
            
        }else if(selectedIndex == 3){
            
            addDetailsViewContoller(DetailsViewController.AccountViewController)
            
        }else if(selectedIndex == 4){
            
            addDetailsViewContoller(DetailsViewController.SettingsViewController)
            
        }else {
            
            addDetailsViewContoller(DetailsViewController.HelpTableViewController)
            
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = false
    }
    
    
    func addDetailsViewContoller(viewControllerEnumValue:DetailsViewController){
        
        switch(viewControllerEnumValue){
            
        case .MainSearchViewController:
            
            var mainSearchViewController:MainSearchViewController = UIStoryboard.mainSearchViewController()!
            mainSearchViewController.delegate = self
            
            // wrap the centerViewController in a navigation controller, so we can push views to it
            // and display bar button items in the navigation bar
            centerNavigationController = UINavigationController(rootViewController: mainSearchViewController)
            view.addSubview(centerNavigationController.view)
            addChildViewController(centerNavigationController)
            
            centerNavigationController.didMoveToParentViewController(self)
            
           
        case .InstitutesTableViewController:
            
            var detailsViewController:InstitutesTableViewController = UIStoryboard.institutesTableViewController()!
            detailsViewController.delegate = self
            
            // wrap the centerViewController in a navigation controller, so we can push views to it
            // and display bar button items in the navigation bar
            centerNavigationController = UINavigationController(rootViewController: detailsViewController)
            view.addSubview(centerNavigationController.view)
            addChildViewController(centerNavigationController)
            
            
            centerNavigationController.didMoveToParentViewController(self)
            
            
        case .CoursesTableViewController:
            
            var coursesTableViewController:CoursesTableViewController = UIStoryboard.coursesTableViewController()!
            coursesTableViewController.delegate = self
            
            // wrap the centerViewController in a navigation controller, so we can push views to it
            // and display bar button items in the navigation bar
            centerNavigationController = UINavigationController(rootViewController: coursesTableViewController)
            view.addSubview(centerNavigationController.view)
            addChildViewController(centerNavigationController)
            
            
            centerNavigationController.didMoveToParentViewController(self)
            
           
            
        case .AccountViewController:
            
            var accountViewController:AccountViewController = UIStoryboard.accountViewController()!
            accountViewController.delegate = self
            
            // wrap the centerViewController in a navigation controller, so we can push views to it
            // and display bar button items in the navigation bar
            centerNavigationController = UINavigationController(rootViewController: accountViewController)
            view.addSubview(centerNavigationController.view)
            addChildViewController(centerNavigationController)
            
            centerNavigationController.didMoveToParentViewController(self)
            
    
        case .SettingsViewController:
            
            var detailsViewController:SettingsTableViewController = UIStoryboard.settingsTableViewController()!
            detailsViewController.delegate = self
            
            // wrap the centerViewController in a navigation controller, so we can push views to it
            // and display bar button items in the navigation bar
            centerNavigationController = UINavigationController(rootViewController: detailsViewController)
            view.addSubview(centerNavigationController.view)
            addChildViewController(centerNavigationController)
            
            centerNavigationController.didMoveToParentViewController(self)
            
            
            
        case .HelpTableViewController:
            
            var helpTableViewController:HelpTableViewController = UIStoryboard.helpTableViewController()!
            helpTableViewController.delegate = self
            
            // wrap the centerViewController in a navigation controller, so we can push views to it
            // and display bar button items in the navigation bar
            centerNavigationController = UINavigationController(rootViewController: helpTableViewController)
            view.addSubview(centerNavigationController.view)
            addChildViewController(centerNavigationController)
            
            
            centerNavigationController.didMoveToParentViewController(self)
            
            

        default:
            break
        }
      
    }
    
}

// MARK: CenterViewController delegate
extension ContainerViewController: CenterViewControllerDelegate {
    
    func toggleLeftPanel() {
        
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
        if notAlreadyExpanded {
          
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func collapseSidePanels() {
       
        switch (currentState) {
            
        case .LeftPanelExpanded:
          
            toggleLeftPanel()
        
        default:
            break
        }
    }
    
    func addLeftPanelViewController() {
        
        if (menuSliderViewController == nil) {
            
            menuSliderViewController = UIStoryboard.menuSliderViewController()
            
            menuSliderViewController!.menuItemsArray = MenuItem.getAllMenuItems()
            
            addChildSidePanelController(menuSliderViewController!)
            
            
        }
    }
    
    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
       
        
        sidePanelController.containerViewDelegate = self
        
        view.insertSubview(sidePanelController.view, atIndex: 0)
        
        addChildViewController(sidePanelController)
        
        sidePanelController.didMoveToParentViewController(self)
    }
    
    
    func animateLeftPanel(#shouldExpand: Bool) {
       
        if (shouldExpand) {
            
            currentState = .LeftPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: CGRectGetWidth(centerNavigationController.view.frame) - centerPanelExpandedOffset)
            
        } else {
            
            animateCenterPanelXPosition(targetPosition: 0) {finished in
                
                self.currentState = .BothCollapsed
                self.menuSliderViewController!.view.removeFromSuperview()
                self.menuSliderViewController = nil;
            }
        }
    }
    
    func animateCenterPanelXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
 
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        
        if (shouldShowShadow) {
            
            centerNavigationController.view.layer.shadowOpacity = 0.8
            
        } else {
            
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    func replaceViewController(row:NSInteger){
        
        self.currentState = .BothCollapsed
        
        centerNavigationController.removeFromParentViewController()
        
        if(row == 0){
            
            addDetailsViewContoller(DetailsViewController.MainSearchViewController)
            
        }else if(row == 1){
            
            addDetailsViewContoller(DetailsViewController.InstitutesTableViewController)
            
        }else{
            
            addDetailsViewContoller(DetailsViewController.SettingsViewController)
            
        }
        
    }
    
}

extension ContainerViewController: UIGestureRecognizerDelegate {
    // MARK: Gesture recognizer
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
        
        switch(recognizer.state) {
            
        case .Began:
            
            if (currentState == .BothCollapsed) {
                
                if (gestureIsDraggingFromLeftToRight) {
                    
                    addLeftPanelViewController()
                }
                
                showShadowForCenterViewController(true)
            }
        case .Changed:
            
            recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
            recognizer.setTranslation(CGPointZero, inView: view)
            
        case .Ended:
            if (menuSliderViewController != nil) {
                
                // animate the side panel open or closed based on whether the view has moved more or less than halfway
                let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
            }
        default:
            break
        }
    }
}
extension ContainerViewController: ContainerViewControllerDelegate {
    
    func replaceDetailsViewController(row:NSInteger){
    
        self.currentState = .BothCollapsed
        
        centerNavigationController.removeFromParentViewController()
        
        if(row == 0){
            
            addDetailsViewContoller(DetailsViewController.MainSearchViewController)

        }else if(row == 1){
            
            addDetailsViewContoller(DetailsViewController.InstitutesTableViewController)
            
        }else if(row == 2){
            
            addDetailsViewContoller(DetailsViewController.CoursesTableViewController)
            
        }else if(row == 3){
            
            addDetailsViewContoller(DetailsViewController.AccountViewController)
            
        }else if(row == 4){
            
            addDetailsViewContoller(DetailsViewController.SettingsViewController)
            
        }else{
            
            addDetailsViewContoller(DetailsViewController.HelpTableViewController)
            
        }
        
    }
    
}
private extension UIStoryboard{
    
    class func mainStoryboard() -> UIStoryboard {
    
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    }
    
    class func menuSliderViewController() -> SidePanelViewController? {
        
        return mainStoryboard().instantiateViewControllerWithIdentifier("SidePanelViewController") as? SidePanelViewController
        
    }
    
    class func mainSearchViewController() -> MainSearchViewController? {
        
        return mainStoryboard().instantiateViewControllerWithIdentifier("MainSearchViewController") as? MainSearchViewController
        
    }
    
    class func institutesTableViewController() -> InstitutesTableViewController? {
        
        return mainStoryboard().instantiateViewControllerWithIdentifier("InstitutesTableViewController") as? InstitutesTableViewController
        
    }
    class func coursesTableViewController() -> CoursesTableViewController? {
        
        return mainStoryboard().instantiateViewControllerWithIdentifier("CoursesTableViewController") as? CoursesTableViewController
        
    }
    class func accountViewController() -> AccountViewController? {
        
        return mainStoryboard().instantiateViewControllerWithIdentifier("AccountViewController") as? AccountViewController
        
    }
    
    class func settingsTableViewController() -> SettingsTableViewController? {
        
        return mainStoryboard().instantiateViewControllerWithIdentifier("SettingsTableViewController") as? SettingsTableViewController
        
    }

    class func helpTableViewController() -> HelpTableViewController? {
        
        return mainStoryboard().instantiateViewControllerWithIdentifier("HelpTableViewController") as? HelpTableViewController
        
    }

    
}