//
//  DataModel.swift
//  Checklists
//
//  Created by Dunja Acimovic on 14.04.2021..
//

import Foundation

class DataModel {
    var lists = [Checklist]()
    var indexOfSelectedChecklist: Int {
        get { return UserDefaults.standard.integer(forKey: "ChecklistIndex") }
        set { UserDefaults.standard.set(newValue, forKey: "ChecklistIndex") }
    }
    
    init() {
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
    
    func registerDefaults() {
        let dictionary: [String: Any] = [
            "ChecklistIndex": 1,
            "FirstTime": true
        ]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    func handleFirstTime() {
        if UserDefaults.standard.bool(forKey: "FirstTime") {
            lists.append(Checklist("List"))
            indexOfSelectedChecklist = 0
            UserDefaults.standard.set(false, forKey: "FirstTime")
        }
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklist.plist")
    }

    func saveChecklists() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }

    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                lists = try decoder.decode([Checklist].self, from: data)
            } catch {
                print("Error decoding item array \(error.localizedDescription)")
            }
        }
    }
}
