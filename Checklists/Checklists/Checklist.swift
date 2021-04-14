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
    
    init(_ name: String, _ items: [ChecklistItem] = []) {
        self.name = name
        self.items = items
        super.init()
    }
}
