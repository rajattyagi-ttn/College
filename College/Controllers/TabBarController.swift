//
//  TabBarController.swift
//  College
//
//  Created by Rajat Tyagi on 15/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, Storyboarded {
    
    var tabBarViewModel = TabBarViewModel()
    
    let student = StudentCoordinator(navigationController: UINavigationController())
    let course = CourseCoordinator(navigationController: UINavigationController())
    let project = ProjectCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarViewModel.setupEverything()
        student.start()
        course.start()
        project.start()
        viewControllers = [student.navigationController,course.navigationController,project.navigationController]
    }
    

    
}
