//
//  CourseCoordinator.swift
//  College
//
//  Created by Rajat Tyagi on 16/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class CourseCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CoursesController.instantiate()
        vc.tabBarItem = UITabBarItem(title: "Course", image: UIImage(systemName: "pencil"), tag: 1)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func courseDetail(courseId: Int) {
        let vc = CoursesDetailController.instantiate()
        vc.courseId = courseId
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
