//
//  ProjectDetailController.swift
//  College
//
//  Created by Rajat Tyagi on 06/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectDetailController: UIViewController, Storyboarded {

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectIdLabel: UILabel!
    @IBOutlet weak var studentAttachedTableView: UITableView!
    
    let realm = try! Realm()
    
    var projectId = 2
    var recievedStudentId = 1
    weak var coordinator: ProjectCoordinator?
    
    var projectDetailViewModel = ProjectDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        projectDetailViewModel.getProject(projectId: projectId)
        
        projectIdLabel.text = "Course ID : \(projectDetailViewModel.project.projectId.description)"
        projectNameLabel.text = "Course Name : \(projectDetailViewModel.project.name)"
        
        let nib = UINib.init(nibName: "StudentTableViewCell", bundle: nil)
        studentAttachedTableView.register(nib, forCellReuseIdentifier: "StudentTVCell")
        
    }
    @IBAction func addStudentButtonTapped(_ sender: UIButton) {

        coordinator?.addStudent(fromViewController: self)
    }
    
}

extension ProjectDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return projectDetailViewModel.project?.attachedStudents.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studentAttachedTableView.dequeueReusableCell(withIdentifier: "StudentTVCell", for: indexPath) as! StudentTableViewCell
        guard let projectName = projectDetailViewModel.project?.attachedStudents[indexPath.row].name else { return cell }
        cell.studentNameLabel.text = "\(indexPath.row + 1). \(projectName)"
        
        return cell
        
    }
    
    
}

extension ProjectDetailController: StudentProtocol {
    
   
    func getSelectedStudent(studentId: Int) {
        self.recievedStudentId = studentId
        projectDetailViewModel.attachStudent(projectId: projectId, studentId: studentId)
        studentAttachedTableView.reloadData()
        
    }
    
    
}
