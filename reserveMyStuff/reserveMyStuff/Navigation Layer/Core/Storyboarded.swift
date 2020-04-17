//
//  Storyboarded.swift
//  canWeCoodinate
//
//  Created by Josh Franco on 3/28/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import UIKit

enum Storyboards: String {
    case main = "Main"
}

protocol Storyboarded: class {
    static var storyboard: Storyboards { get set }
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let viewControllerType = type(of: self)
        let viewControllerFullName = String(describing: viewControllerType)
        let viewControllerName = viewControllerFullName.components(separatedBy: ".")[0]
        
        
        let storyboard = UIStoryboard(name: self.storyboard.rawValue,
                                      bundle: Bundle(for: self))
        
        
        return storyboard.instantiateViewController(withIdentifier: viewControllerName) as! Self
    }
}
