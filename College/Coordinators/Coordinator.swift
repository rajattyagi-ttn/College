//
//  Coordinator.swift
//  College
//
//  Created by Rajat Tyagi on 15/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
