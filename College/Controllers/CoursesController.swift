//
//  CoursesController.swift
//  College
//
//  Created by Rajat Tyagi on 03/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import RealmSwift

class CoursesController: UIViewController, Storyboarded {

    @IBOutlet weak var coursesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    weak var coordinator: CourseCoordinator?
    
    var courseViewModel = CourseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib.init(nibName: "CoursesTableViewCell", bundle: nil)
        coursesTableView?.register(nib, forCellReuseIdentifier: "CoursesTVCell")
        
        searchBar?.delegate = self

        courseViewModel.getCourseList()
        
    }

}


extension CoursesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseViewModel.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
            let cell = coursesTableView.dequeueReusableCell(withIdentifier: "CoursesTVCell", for: indexPath) as! CoursesTableViewCell
            cell.courseNameLabel.text = courseViewModel.filteredData[indexPath.row].courseDisplayName
            return cell
        }
        
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70.0
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        coordinator?.courseDetail(courseId: courseViewModel.filteredData[indexPath.row].courseId)
    }
    
}

extension CoursesController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        courseViewModel.filteredData = searchText.isEmpty ? courseViewModel.courses : courseViewModel.courses?.filter { (item: Course) -> Bool in
          
            return item.courseDisplayName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        coursesTableView.reloadData()
    }
}
