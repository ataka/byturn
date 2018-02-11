//
//  PersonListTableViewController.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/08.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class PersonListTableViewController: UITableViewController, UISearchResultsUpdating {
    @IBOutlet var doneButton: UIBarButtonItem!

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
        prepareView()
        prepareRxBinding()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Preparation

    private func prepareView() {
        navigationItem.searchController = {
            let search = UISearchController(searchResultsController: nil)
            search.searchResultsUpdater = self
            search.dimsBackgroundDuringPresentation = false
            return search
        }()
    }

    private func prepareRxBinding() {
        viewModel.canSave.asObservable()
            .subscribeOn(ConcurrentMainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .bind(to: doneButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Person", for: indexPath)
        let person = viewModel.source(at: indexPath)

        cell.textLabel?.text = person.name
        cell.accessoryType = person.isSelected ? .checkmark : .none
        cell.backgroundColor = {
            switch person.recordCount {
            case 0: return .white
            case 1: return .yellow
            case 2: return .blue
            case 3: return .green
            default:
                return .white
            }
        }()

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let person = viewModel.source(at: indexPath)

        cell.accessoryType = {
            viewModel.toggleSelect(person: person)
            return person.isSelected ? .checkmark : .none
        }()

        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        let keywoards = text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespaces).filter { !$0.isEmpty }
        viewModel.search(by: keywoards, where: PersonCellViewModel.filterByName(keywords: keywoards))
        tableView.reloadData()
    }

    // MARK: - Action

    @IBAction func record(_: Any) {
        viewModel.record()
    }
}
