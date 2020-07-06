//
//  Course.swift
//  College
//
//  Created by Rajat Tyagi on 02/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import Foundation
import RealmSwift

class Course: Object {
    @objc dynamic var courseId: Int
    @objc  dynamic var courseDisplayName = CourseName.BTech.rawValue
    
    var name: CourseName {
        get { return CourseName(rawValue: courseDisplayName)! }
        set {
            courseDisplayName = newValue.rawValue
        }
    }
    
    
    let enrolledStudents = LinkingObjects(fromType: Student.self, property: "course")
    
    required init(courseId: Int, name: CourseName) {
        self.courseId = courseId
        self.courseDisplayName = name.rawValue
    }
    
    required init() {
        courseId = 0
    }
    

}

enum CourseName: String {
    case BTech, MTech, BBA, MBA, BCA, MCA, BCom, MCom
}
