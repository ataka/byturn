//
//  PersonListTableViewController.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/08.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PersonListTableViewController: UITableViewController {
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    private let disposeBag = DisposeBag()
    private var viewModel: PersonListViewModel!
    
    // MARK: - Life Cycle
    
    static func instantiateViewController(viewModel: PersonListViewModel) -> PersonListTableViewController {
        let storyboard = UIStoryboard(name: "PersonList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PersonList") as! PersonListTableViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareRxBinding()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Preparation
    
    private func prepareRxBinding() {
        viewModel.canSave.asObservable()
            .subscribeOn(ConcurrentMainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .bind(to: doneButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Person", for: indexPath)
        let person = viewModel.dataSource[indexPath.row]
        
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let person = viewModel.dataSource[indexPath.row]
        
        cell.accessoryType = {
            viewModel.toggleSelect(person: person)
            return person.isSelected ? .checkmark : .none
        }()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
