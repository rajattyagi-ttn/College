//
//  CourseViewModel.swift
//  College
//
//  Created by Rajat Tyagi on 18/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import Foundation
import RealmSwift

class CourseViewModel {
    let realm = try! Realm()
    
    var courseList: Results<Course>?
    var courses: [Course]!
    var filteredData: [Course]!
    
    func getCourseList()  {
        self.courseList = realm.objects(Course.self)
        self.courses = courseList?.toArray()
        self.filteredData = courses
    }

}
