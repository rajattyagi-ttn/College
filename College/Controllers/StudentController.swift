//
//  StudentController.swift
//  College
//
//  Created by Rajat Tyagi on 03/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import RealmSwift

class StudentController: UIViewController, Storyboarded {

    @IBOutlet weak var studentTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var coordinator: StudentCoordinator?
    
    var studentViewModel = StudentViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib.init(nibName: "StudentTableViewCell", bundle: nil)
        studentTableView?.register(nib, forCellReuseIdentifier: "StudentTVCell")
        searchBar?.delegate = self
        
        studentViewModel.getStudentList()

 
    }

}


extension StudentController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentViewModel.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = studentTableView.dequeueReusableCell(withIdentifier: "StudentTVCell", for: indexPath) as! StudentTableViewCell
        cell.studentNameLabel.text = studentViewModel.filteredData[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        coordinator?.studentDetail(studentId: studentViewModel.filteredData[indexPath.row].id)
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}


extension StudentController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        studentViewModel.filteredData = searchText.isEmpty ? studentViewModel.students : studentViewModel.students?.filter { (item: Student) -> Bool in
           
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
