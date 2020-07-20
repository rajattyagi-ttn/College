//
//  Storyboarded.swift
//  College
//
//  Created by Rajat Tyagi on 15/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}


extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}




