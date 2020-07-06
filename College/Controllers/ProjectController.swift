//
//  ProjectController.swift
//  College
//
//  Created by Rajat Tyagi on 03/07/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectController: UIViewController {

    @IBOutlet weak var projectsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()
    var projectList: Results<Project>?
    var projectsArray: [Project]!
    var filteredData: [Project]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "ProjectTableViewCell", bundle: nil)
        projectsTableView.register(nib, forCellReuseIdentifier: "ProjectTVCell")
        
        searchBar.delegate = self
        projectList = realm.objects(Project.self)
        projectsArray = projectList?.toArray()
        filteredData = projectsArray
        
       
    }

}


extension ProjectController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = projectsTableView.dequeueReusableCell(withIdentifier: "ProjectTVCell", for: indexPath) as! ProjectTableViewCell
        cell.projectNameLabel.text = filteredData[indexPath.row].name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProjectDetailController") as! ProjectDetailController
        vc.projectId = filteredData[indexPath.row].projectId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
}


extension ProjectController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = searchText.isEmpty ? projectsArray : projectsArray?.filter { (item: Project) -> Bool in
            
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        projectsTableView.reloadData()
    }
}
