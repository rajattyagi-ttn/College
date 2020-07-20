//
//  AddStudentController.swift
//  College
//
//  Created by Rajat Tyagi on 06/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import RealmSwift

public protocol StudentProtocol {
    
    func getSelectedStudent(studentId: Int)
}

class AddStudentController: UIViewController, Storyboarded {

    @IBOutlet weak var addStudentTableView: UITableView!
    
    let realm = try! Realm()
    var notAssignedStudentList = [Student]()
    var studentDelegate: StudentProtocol!
    weak var coordinator: ProjectCoordinator?
    
    var addStudentViewModel = AddStudentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addStudentViewModel.getNotAssignedStudents()

        let nib = UINib.init(nibName: "StudentTableViewCell", bundle: nil)
        addStudentTableView.register(nib, forCellReuseIdentifier: "StudentTVCell")
        
    }
    
}

extension AddStudentController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return addStudentViewModel.notAssignedStudents.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addStudentTableView.dequeueReusableCell(withIdentifier: "StudentTVCell", for: indexPath) as! StudentTableViewCell
        cell.studentNameLabel.text = addStudentViewModel.notAssignedStudents[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        studentDelegate.getSelectedStudent(studentId: addStudentViewModel.notAssignedStudents[indexPath.row].id)
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
}
