//
//  CourseDetailViewModel.swift
//  College
//
//  Created by Rajat Tyagi on 18/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import Foundation
import RealmSwift

class CourseDetailViewModel {
    let realm = try! Realm()
    
    var course: Course!
    
    func getCourse(courseId: Int) {
        let courseList = realm.objects(Course.self).filter("courseId = \(courseId)")
        self.course = courseList.last
    }

}
