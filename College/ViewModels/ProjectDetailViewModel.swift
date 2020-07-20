//
//  ProjectDetailViewModel.swift
//  College
//
//  Created by Rajat Tyagi on 18/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import Foundation
import RealmSwift

class ProjectDetailViewModel {
    let realm = try! Realm()
    
    var project: Project!
    
    func getProject(projectId: Int) {
        let projectList = realm.objects(Project.self).filter("projectId = \(projectId)")
        self.project = projectList.last
    }
    
    func attachStudent(projectId: Int, studentId: Int) {
        let selectedProjects = realm.objects(Project.self).filter("projectId = \(projectId)")
        let selectedProject = selectedProjects.last
        
        let selectedStudents = realm.objects(Student.self).filter("id = \(studentId)")
        let selectedStudent = selectedStudents.last
        
        try! realm.write{
            selectedStudent?.project = selectedProject
        }
    }

}
