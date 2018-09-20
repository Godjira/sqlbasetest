//
//  UIStoryboardExtensions.swift
//  sqltest
//
//  Created by betraying on 9/19/18.
//  Copyright © 2018 Godjira. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    class func viewController<T: UIViewController>(type: T.Type) -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
}
