//
//  ProjectCoordinator.swift
//  College
//
//  Created by Rajat Tyagi on 16/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class ProjectCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ProjectController.instantiate()
        vc.tabBarItem = UITabBarItem(title: "Projects", image: UIImage(systemName: "tuningfork"), tag: 2)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func projectDetail(projectId: Int) {
        let vc = ProjectDetailController.instantiate()
        vc.projectId = projectId
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
        
    
    func addStudent(fromViewController: UIViewController) {
        let vc = AddStudentController.instantiate()
        vc.coordinator = self
        vc.studentDelegate = (fromViewController as! StudentProtocol)
        navigationController.pushViewController(vc, animated: true)
//        vc.present(vc, animated: true, completion: nil)
     
    }
    
    
}
