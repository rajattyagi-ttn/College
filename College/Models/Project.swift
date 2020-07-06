//
//  Project.swift
//  College
//
//  Created by Rajat Tyagi on 03/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import Foundation
import RealmSwift

class Project: Object {
    @objc dynamic var projectId: Int
    @objc dynamic var name: String
    var attachedStudents = LinkingObjects(fromType: Student.self, property: "project")
    
    required init(projectId: Int, name: String) {
        self.projectId = projectId
        self.name = name
    }
    
    required init() {
        projectId = 0
        name = ""
    }

}
