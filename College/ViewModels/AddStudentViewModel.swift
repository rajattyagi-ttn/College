//
//  AddStudentViewModel.swift
//  College
//
//  Created by Rajat Tyagi on 18/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import Foundation
import RealmSwift

class AddStudentViewModel {
    
    let realm = try! Realm()
    
    var notAssignedStudents = [Student]()
    
    func getNotAssignedStudents() {
        let studentList = realm.objects(Student.self)
        for student in studentList {
            if student.project == nil {
                self.notAssignedStudents.append(student)
            }
       }
    }
}
