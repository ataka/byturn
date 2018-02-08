//
//  PersonListTableViewController.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/08.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import UIKit

class PersonListTableViewController: UITableViewController {
    private var viewModel: PersonListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    static func instantiateViewController(viewModel: PersonListViewModel) -> PersonListTableViewController {
        let storyboard = UIStoryboard(name: "PersonList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PersonList") as! PersonListTableViewController
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Person", for: indexPath)
        let person = viewModel.people[indexPath.row]
        
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let person = viewModel.people[indexPath.row]
        
        cell.accessoryType = {
            person.toggleSelect()
            return person.isSelected ? .checkmark : .none
        }()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
