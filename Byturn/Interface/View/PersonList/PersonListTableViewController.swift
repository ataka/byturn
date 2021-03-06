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

    var locationId: LocationId!

    private let disposeBag = DisposeBag()
    private var viewModel: PersonListViewModel!

    // MARK: - Life Cycle

    static func instantiateViewController(locationId: LocationId) -> PersonListTableViewController {
        let viewController = UIStoryboard(name: "PersonList", bundle: nil)
            .instantiateViewController(withIdentifier: "PersonList") as! PersonListTableViewController
        viewController.locationId = locationId
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PersonListViewModel(locationId: locationId)
        prepareView()
        prepareRxBinding()
        prepareRxEvent()
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

    private func prepareRxEvent() {
        viewModel.rx_didRecord
            .subscribeOn(ConcurrentMainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                self.tableView.reloadData()
            })
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
        let personViewModel = viewModel.source(at: indexPath)

        cell.textLabel?.text = personViewModel.name
        cell.accessoryType = personViewModel.isSelected ? .checkmark : .none
        cell.backgroundColor = {
            switch personViewModel.recordCount {
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
        let personViewModel = viewModel.source(at: indexPath)

        cell.accessoryType = {
            viewModel.toggleSelection(personViewModel: personViewModel)
            return personViewModel.isSelected ? .checkmark : .none
        }()

        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        let keywoards = text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespaces).filter { !$0.isEmpty }
        viewModel.search(by: keywoards, where: PersonCellViewModel.filter(byName: keywoards))
        tableView.reloadData()
    }

    // MARK: - Action

    @IBAction func record(_: Any) {
        viewModel.record()
    }
}
