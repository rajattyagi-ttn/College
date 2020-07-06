//
//  StudentDetailController.swift
//  College
//
//  Created by Rajat Tyagi on 05/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import RealmSwift

class StudentDetailController: UIViewController {

    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentIdLabel: UILabel!
    @IBOutlet weak var studentCourseLabel: UILabel!
    @IBOutlet weak var studentProjectLabel: UILabel!
    
    var studentId = 1
    let realm = try! Realm()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let selectedStudentList = realm.objects(Student.self).filter("id = \(studentId)")
        let selectedStudent = selectedStudentList.last
        configureStudent(student: selectedStudent!)
    }
    
    func configureStudent(student: Student) {
        self.studentNameLabel.text = "Name : \(student.name)"
        self.studentIdLabel.text = "ID : \(student.id.description)"
        self.studentCourseLabel.text = "Course : \(student.course!.courseDisplayName)"
        guard let projectName = student.project?.name else { self.studentProjectLabel.text = " Project : Not Assigned"
            return}
        self.studentProjectLabel.text = "Project : \(projectName)"
    }

}
