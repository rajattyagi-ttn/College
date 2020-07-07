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
    
    var studentList: Results<Student>?
    var selectedStudent: Student?
    var messageToken: NotificationToken?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.studentList = realm.objects(Student.self).filter("id = \(studentId)")
        
        selectedStudent = studentList?.last

        configureStudent(student: selectedStudent!)
        
        updateProjectOnChange()
        
    }
    
    func updateProjectOnChange() {
        messageToken = selectedStudent?.observe { [weak self] change in
            switch change {
            case .change(_ , let properties):
                
                    
                for property in properties {
                    if property.name == "project" && property.newValue != nil {
                        try! self?.realm.write {
                            self?.selectedStudent?.project = (property.newValue as! Project)
                        }
                        guard let updatedProjectName = self?.selectedStudent?.project?.name else {return}
                        self?.studentProjectLabel.text = "Project : \(String(describing: updatedProjectName))"
                        
                        self?.messageToken = nil
                    }
                }
            case .error(let error):
                print("An error occurred: \(error)")
            case .deleted:
                print("The object was deleted.")
                
            }
            
        }
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
