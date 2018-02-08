//
//  LocationListTableViewController.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/07.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import UIKit

final class LocationListTableViewController: UITableViewController {
    private var viewModel: LocationListViewModel!
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LocationListViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locationId = viewModel.locations[indexPath.row].id
        let viewModel = PersonListViewModel()
        let viewController = PersonListTableViewController.instantiateViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
