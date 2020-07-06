//
//  Student.swift
//  College
//
//  Created by Rajat Tyagi on 02/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import Foundation
import RealmSwift

class Student: Object {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var course: Course?
//    var courses = List<Course>()
    @objc dynamic var project: Project?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    required init() {
        id = 0
        name = ""
    }
    
    
    
}
