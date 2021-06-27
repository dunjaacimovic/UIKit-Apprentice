//
//  Checklist.swift
//  Checklists
//
//  Created by Dunja Acimovic on 05.04.2021..
//

import UIKit

class Checklist: NSObject, Codable {
    var name: String
    var items: [ChecklistItem]
    var iconName = "No icon"
    
    init(_ name: String, _ items: [ChecklistItem] = []) {
        self.name = name
        self.items = items
        super.init()
    }
    
    func countUncheckedItems() -> Int {
        let count = items
            .map { $0.isChecked ? 0 : 1 }
            .reduce(0, +)
        return count
    }
}
