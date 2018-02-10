//
//  PersonListViewModel.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/08.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation
import RxCocoa

final class PersonListViewModel {
    let people: [PersonCellViewModel]
    let canSave: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var selectedCount: Int = 0 {
        didSet {
            canSave.accept(selectedCount > 0)
        }
    }
    
    init(locationId: LocationId) {
        self.people = PersonListViewModel.loadPeople().filter { $0.locationId == locationId }.map(PersonCellViewModel.init)
    }
    
    // Preparation
    
    private static func loadPeople() -> [Person] {
        guard let path = Bundle.main.path(forResource: "Person", ofType: "plist"),
            let plist = NSArray(contentsOfFile: path) as? [[String: Any]] else { return [] }
        return plist.flatMap {
            guard let id = $0["id"] as? Int,
                let locationId = $0["locationId"] as? Int,
                let name = $0["name"] as? String,
                let order = $0["order"] as? PersonOrder else { return nil }
            return Person.init(id: PersonId(id: id), locationId: LocationId(id: locationId), name: name, order: order, turnAts: [])
        }
    }
    
    // MARK: - Select
    
    func toggleSelect(person: PersonCellViewModel) {
        person.toggleSelect()
        selectedCount += person.isSelected ? +1 : -1
    }
}
