//
//  CoursesController.swift
//  College
//
//  Created by Rajat Tyagi on 03/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import RealmSwift

class CoursesController: UIViewController {

    @IBOutlet weak var coursesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()
    var courseList: Results<Course>?
    var coursesArray: [Course]!
    var filteredData: [Course]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib.init(nibName: "CoursesTableViewCell", bundle: nil)
        coursesTableView.register(nib, forCellReuseIdentifier: "CoursesTVCell")
        
        searchBar.delegate = self
        courseList = realm.objects(Course.self)
        coursesArray = courseList?.toArray()
        filteredData = coursesArray
        
    }

}


extension CoursesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
            let cell = coursesTableView.dequeueReusableCell(withIdentifier: "CoursesTVCell", for: indexPath) as! CoursesTableViewCell
            cell.courseNameLabel.text = filteredData[indexPath.row].courseDisplayName
            return cell
        }
        
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70.0
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CoursesDetailController") as! CoursesDetailController
        vc.courseId = filteredData[indexPath.row].courseId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CoursesController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = searchText.isEmpty ? coursesArray : coursesArray?.filter { (item: Course) -> Bool in
          
            return item.courseDisplayName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        coursesTableView.reloadData()
    }
}
