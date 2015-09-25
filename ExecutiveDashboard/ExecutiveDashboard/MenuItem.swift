//
//  Animal.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit

@objc
class MenuItem {
  
  let title: String
  let creator: String
  let image: UIImage?
  
  init(title: String, creator: String, image: UIImage?) {
    
    self.title = title
    self.creator = creator
    self.image = image
    
  }
  
  class func getAllMenuItems() -> Array<MenuItem> {
    
    return [ MenuItem(title: "Address", creator: "address", image: UIImage(named: "address.png")),
        MenuItem(title: "Institutes", creator: "institutes", image: UIImage(named: "institutes.png")),
        MenuItem(title: "Courses", creator: "courses", image: UIImage(named: "course.png")),
        MenuItem(title: "Account", creator: "account", image: UIImage(named: "account.png")),
        MenuItem(title: "Settings", creator: "settings", image: UIImage(named: "settings.png")),
        MenuItem(title: "Help", creator: "help", image: UIImage(named: "help.png"))]
    
  }
  
}