//
//  ProjectDetailController.swift
//  College
//
//  Created by Rajat Tyagi on 06/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectDetailController: UIViewController {

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectIdLabel: UILabel!
    @IBOutlet weak var studentAttachedTableView: UITableView!
    
    var projectId = 1
    let realm = try! Realm()
    var recievedStudentId = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let selectedProjects = realm.objects(Project.self).filter("projectId = \(projectId)")
        let selectedProject = selectedProjects.last
        
        projectIdLabel.text = "Course ID : \(selectedProject!.projectId.description)"
        projectNameLabel.text = "Course Name : \(selectedProject!.name)"
        
        let nib = UINib.init(nibName: "StudentTableViewCell", bundle: nil)
        studentAttachedTableView.register(nib, forCellReuseIdentifier: "StudentTVCell")
        
    }
    @IBAction func addStudentButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddStudentController") as! AddStudentController
        vc.studentDelegate = self
//        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension ProjectDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedProjects = realm.objects(Project.self).filter("projectId = \(projectId)")
        let selectedProject = selectedProjects.last
        
        return selectedProject?.attachedStudents.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedProjects = realm.objects(Project.self).filter("projectId = \(projectId)")
        let selectedProject = selectedProjects.last
        
        let cell = studentAttachedTableView.dequeueReusableCell(withIdentifier: "StudentTVCell", for: indexPath) as! StudentTableViewCell
        guard let studentName = selectedProject?.attachedStudents[indexPath.row].name else { return cell }
        cell.studentNameLabel.text = "\(indexPath.row + 1). \(studentName)"
        
        return cell
        
    }
    
    
}

extension ProjectDetailController: StudentProtocol {
    
   
    func getSelectedStudent(studentId: Int) {
        self.recievedStudentId = studentId
        
        let selectedProjects = realm.objects(Project.self).filter("projectId = \(projectId)")
        let selectedProject = selectedProjects.last
        
        let selectedStudents = realm.objects(Student.self).filter("id = \(studentId)")
        let selectedStudent = selectedStudents.last
        
        try! realm.write{
            selectedStudent?.project = selectedProject
        }
        
        studentAttachedTableView.reloadData()
        
    }
    
    
}
