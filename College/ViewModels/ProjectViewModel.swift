//
//  ProjectViewModel.swift
//  College
//
//  Created by Rajat Tyagi on 18/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import Foundation
import RealmSwift

class ProjectViewModel {
    let realm = try! Realm()
    
    var projectList: Results<Project>?
    var projects: [Project]!
    var filteredData: [Project]!
    
    func getProjectList()  {
        self.projectList = realm.objects(Project.self)
        self.projects = projectList?.toArray()
        self.filteredData = projects
    }

}
