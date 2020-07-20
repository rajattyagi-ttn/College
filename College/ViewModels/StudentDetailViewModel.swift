//
//  StudentDetailViewModel.swift
//  College
//
//  Created by Rajat Tyagi on 18/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import Foundation
import RealmSwift

class StudentDetailViewModel {
    let realm = try! Realm()
    
    var student: Student!
    var messageToken: NotificationToken?
    
    
    
    func getStudent(studentId: Int) {
        let studentList = realm.objects(Student.self).filter("id = \(studentId)")
        
        self.student = studentList.last
    }


}
