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

    override func numberOfSections(in _: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Location", for: indexPath)
        let location = viewModel.source(at: indexPath)

        cell.textLabel?.text = location.name

        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = viewModel.source(at: indexPath)
        let viewController = PersonListTableViewController.instantiateViewController(locationId: location.id)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
