//
//  StudentController.swift
//  College
//
//  Created by Rajat Tyagi on 03/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import RealmSwift

class StudentController: UIViewController {

    @IBOutlet weak var studentTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()
    var studentList: Results<Student>?
    var studentArray: [Student]!
    var filteredData: [Student]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib.init(nibName: "StudentTableViewCell", bundle: nil)
        studentTableView.register(nib, forCellReuseIdentifier: "StudentTVCell")
        searchBar.delegate = self
        
        try! realm.write() {
            realm.delete(realm.objects(Student.self))
            realm.delete(realm.objects(Course.self))
            realm.delete(realm.objects(Project.self))
        }
        
        createCourses()
        createStudents()
        createProjects()
        
        studentList = realm.objects(Student.self)
        studentArray = studentList?.toArray()
        filteredData = studentArray
        
        
    }
    
    func createCourses() {
        let btechCourse = Course(courseId: 101, name: .BTech)
        let mtechCourse = Course(courseId: 102, name: .MTech)
        let bbaCourse = Course(courseId: 103, name: .BBA)
        let mbaCourse = Course(courseId: 104, name: .MBA)
        let bcaCourse = Course(courseId: 105, name: .BCA)
        let mcaCourse = Course(courseId: 106, name: .MCA)
        let bcomCourse = Course(courseId: 107, name: .BCom)
        let mcomCourse = Course(courseId: 108, name: .MCom)
        
        try! realm.write {
            realm.add(btechCourse)
            realm.add(mtechCourse)
            realm.add(bbaCourse)
            realm.add(mbaCourse)
            realm.add(bcaCourse)
            realm.add(mcaCourse)
            realm.add(bcomCourse)
            realm.add(mcomCourse)
        }
        
    }
    
    func createProjects() {
        let djangoProject = Project(projectId: 1, name: "Django Project")
        let iotProject = Project(projectId: 2, name: "IOT Project")
        let iosProject = Project(projectId: 3, name: "iOS Project")
        let mlProject = Project(projectId: 4, name: "Machine Learning Project")
        let tensorFlowProject = Project(projectId: 5, name: "TensorFlow Project")
       
        
        try! realm.write {
            realm.add(djangoProject)
            realm.add(iotProject)
            realm.add(iosProject)
            realm.add(mlProject)
            realm.add(tensorFlowProject)
        }
        
    }
    
    func createStudents() {
        
        
        let btechCourses = realm.objects(Course.self).filter("courseId = 101")
        let btechCourse = btechCourses.last
        let mtechCourses = realm.objects(Course.self).filter("courseId = 102")
        let mtechCourse = mtechCourses.last
        let bbaCourses = realm.objects(Course.self).filter("courseId = 103")
        let bbaCourse = bbaCourses.last
        let mbaCourses = realm.objects(Course.self).filter("courseId = 104")
        let mbaCourse = mbaCourses.last
        let bcaCourses = realm.objects(Course.self).filter("courseId = 105")
        let bcaCourse = bcaCourses.last
        let mcaCourses = realm.objects(Course.self).filter("courseId = 106")
        let mcaCourse = mcaCourses.last
        let bcomCourses = realm.objects(Course.self).filter("courseId = 107")
        let bcomCourse = bcomCourses.last
        let mcomCourses = realm.objects(Course.self).filter("courseId = 108")
        let mcomCourse = mcomCourses.last
        
        
        
        let rajat = Student(id: 1, name: "Rajat")
        rajat.course = btechCourse!
        
        let komo = Student(id: 2, name: "Komolica")
        komo.course = mbaCourse!
        
        let arun = Student(id: 3, name: "Arun")
        arun.course = btechCourse!
        
        let aman = Student(id: 4, name: "Aman")
        aman.course = mtechCourse!
        
        let sehej = Student(id: 5, name: "Sehej")
        sehej.course = bcomCourse!
        
        
        let shikhar = Student(id: 6, name: "Shikhar")
        shikhar.course = bcomCourse!
        
        let niks = Student(id: 7, name: "Niks")
        niks.course = bcaCourse!
        
        let void = Student(id: 9, name: "Void")
        void.course = mcomCourse!
        
        let vishal = Student(id: 10, name: "Vishal")
        vishal.course = mcaCourse!
        
        let hitesh = Student(id: 11, name: "Hitesh")
        hitesh.course = bbaCourse!
        
        
        
        
        try! realm.write {
            realm.add(rajat)
            realm.add(komo)
            realm.add(arun)
            realm.add(aman)
            realm.add(sehej)
            realm.add(shikhar)
            realm.add(niks)
            realm.add(void)
            realm.add(vishal)
            realm.add(hitesh)
        }
        
    }

}


extension StudentController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let studentList = realm.objects(Student.self)
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = studentTableView.dequeueReusableCell(withIdentifier: "StudentTVCell", for: indexPath) as! StudentTableViewCell
        cell.studentNameLabel.text = filteredData[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StudentDetailController") as! StudentDetailController
        vc.studentId = filteredData[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}


extension StudentController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = searchText.isEmpty ? studentArray : studentArray?.filter { (item: Student) -> Bool in
           
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        studentTableView.reloadData()
    }
}


extension Results {
   func toArray() -> [Element] {
     return compactMap {
       $0
     }
   }
}
