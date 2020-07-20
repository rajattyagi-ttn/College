//
//  StudentViewModel.swift
//  College
//
//  Created by Rajat Tyagi on 18/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import Foundation
import RealmSwift

class StudentViewModel {

    let realm = try! Realm()
    
    var studentList: Results<Student>?
    var students: [Student]!
    var filteredData: [Student]!


    func getStudentList()  {
        self.studentList = realm.objects(Student.self)
        self.students = studentList?.toArray()
        self.filteredData = students
    }
    
    
}
