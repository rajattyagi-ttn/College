//
//  CoursesDetailController.swift
//  College
//
//  Created by Rajat Tyagi on 05/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import RealmSwift

class CoursesDetailController: UIViewController {

    @IBOutlet weak var courseIdLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseDetailTableView: UITableView!
    
    var courseId = 101
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedCourses = realm.objects(Course.self).filter("courseId = \(courseId)")
        let selectedCourse = selectedCourses.last
        
        courseIdLabel.text = "Course ID : \(selectedCourse!.courseId.description)"
        courseNameLabel.text = "Course Name : \(selectedCourse!.courseDisplayName)"
    
        
        let nib = UINib.init(nibName: "StudentTableViewCell", bundle: nil)
        courseDetailTableView.register(nib, forCellReuseIdentifier: "StudentTVCell")
    }
    


}

extension CoursesDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedCourses = realm.objects(Course.self).filter("courseId = \(courseId)")
        let selectedCourse = selectedCourses.last
        
        return selectedCourse?.enrolledStudents.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedCourses = realm.objects(Course.self).filter("courseId = \(courseId)")
        let selectedCourse = selectedCourses.last
        let cell = courseDetailTableView.dequeueReusableCell(withIdentifier: "StudentTVCell", for: indexPath) as! StudentTableViewCell
        guard let studentName = selectedCourse?.enrolledStudents[indexPath.row].name else { return cell }
        cell.studentNameLabel.text = "\(indexPath.row + 1). \(studentName)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
}
