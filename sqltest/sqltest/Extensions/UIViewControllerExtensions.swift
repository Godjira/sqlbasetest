//
//  UIViewControllerExtensions.swift
//  sqltest
//
//  Created by betraying on 9/19/18.
//  Copyright © 2018 Godjira. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func instance() -> Self {
        return UIStoryboard.viewController(type: self)
    }
}
