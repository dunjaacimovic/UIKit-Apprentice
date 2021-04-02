//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Dunja Acimovic on 28.03.2021..
//

import Foundation

class ChecklistItem {
    var text: String
    var isChecked: Bool
    
    init(_ text: String, isChecked: Bool) {
        self.text = text
        self.isChecked = isChecked
    }
}
