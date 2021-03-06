//
//  PersonListViewModel.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/08.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class PersonListViewModel: ListViewModel {
    typealias DataSourceType = DataSource2d<PersonCellViewModel>

    // MARK: - Properties

    let rawDataSource: DataSource2d<PersonCellViewModel>
    var dataSource: DataSource2d<PersonCellViewModel>

    let canSave: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var selectedCount: Int = 0 {
        didSet {
            canSave.accept(selectedCount > 0)
        }
    }

    let rx_didRecord = PublishSubject<[PersonId]>()

    init(locationId: LocationId) {
        rawDataSource = DataSource2d<PersonCellViewModel>
            .init(rows: PersonListService.showPersonList(locationId: locationId).map(PersonCellViewModel.init))
        dataSource = rawDataSource
    }

    // MARK: - Select

    func toggleSelection(personViewModel: PersonCellViewModel) {
        personViewModel.toggleSelect()
        selectedCount += personViewModel.isSelected ? +1 : -1
    }

    // MARK: - Action

    func record() {
        let personIds = rawDataSource.filter { $0.isSelected }.map { $0.personId }
        PersonListService.record(personIds: personIds) { (people: [Person]) in
            people.forEach { person in
                rawDataSource.filter { $0.personId == person.id }.map { $0 }.forEach { personViewModel in
                    personViewModel.clearSelection()
                    personViewModel.update(by: person)
                }
            }
            selectedCount = 0
            rx_didRecord.onNext(personIds)
        }
    }
}
