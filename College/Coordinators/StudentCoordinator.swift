//
//  StudentCoordinator.swift
//  College
//
//  Created by Rajat Tyagi on 16/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class StudentCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
           self.navigationController = navigationController
    }
    
    func start() {
        let vc = StudentController.instantiate()

        vc.tabBarItem = UITabBarItem(title: "Student", image: UIImage(systemName: "person.fill"), tag: 0)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func studentDetail(studentId: Int) {
        let vc = StudentDetailController.instantiate()
        vc.studentId = studentId
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
