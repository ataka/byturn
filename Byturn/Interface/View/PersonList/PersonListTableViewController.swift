//
//  PersonListTableViewController.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/08.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import UIKit

class PersonListTableViewController: UITableViewController {
    private var viewModel: LocationListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LocationListViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    static func instantiateViewController() -> PersonListTableViewController {
        let storyboard = UIStoryboard(name: "PersonList", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "PersonList") as! PersonListTableViewController
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Location", for: indexPath)
        let location = viewModel.locations[indexPath.row]
        
        cell.textLabel?.text = location.name
        
        return cell
    }
}
