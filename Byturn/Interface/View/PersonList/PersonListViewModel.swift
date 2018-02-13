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

    func toggleSelect(person: PersonCellViewModel) {
        person.toggleSelect()
        selectedCount += person.isSelected ? +1 : -1
    }

    private func clearSelection(personIds: [PersonId]) {
        rawDataSource.filter { personIds.contains($0.personId) }.map { $0 }.forEach { selectedPersonViewModel in
            selectedPersonViewModel.clearSelection()
        }
        selectedCount = 0
    }

    // MARK: - Action

    func record() {
        let personIds = rawDataSource.filter { $0.isSelected }.map { $0.personId }
        PersonListService.record(personIds: personIds) { personIds in
            clearSelection(personIds: personIds)
            rx_didRecord.onNext(personIds)
        }
    }
}
