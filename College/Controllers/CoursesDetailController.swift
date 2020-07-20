//
//  CoursesDetailController.swift
//  College
//
//  Created by Rajat Tyagi on 05/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import RealmSwift

class CoursesDetailController: UIViewController, Storyboarded {

    @IBOutlet weak var courseIdLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseDetailTableView: UITableView!
    
    var courseId = 101
    weak var coordinator: CourseCoordinator?
    

    
    var courseDetailViewModel = CourseDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        courseDetailViewModel.getCourse(courseId: courseId)
        
        courseIdLabel.text = "Course ID : \(courseDetailViewModel.course!.courseId.description)"
        courseNameLabel.text = "Course Name : \(courseDetailViewModel.course!.courseDisplayName)"
    
        
        let nib = UINib.init(nibName: "StudentTableViewCell", bundle: nil)
        courseDetailTableView.register(nib, forCellReuseIdentifier: "StudentTVCell")
    }
    


}

extension CoursesDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return courseDetailViewModel.course?.enrolledStudents.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = courseDetailTableView.dequeueReusableCell(withIdentifier: "StudentTVCell", for: indexPath) as! StudentTableViewCell
        guard let courseName = courseDetailViewModel.course?.enrolledStudents[indexPath.row].name else { return cell }
        cell.studentNameLabel.text = "\(indexPath.row + 1). \(courseName)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
}
