//
//  ViewController.swift
//  Checklists
//
//  Created by Dunja Acimovic on 28.03.2021..
//

import UIKit

class ChecklistsViewController: UITableViewController {
    
    var items = [
        ChecklistItem("Walk the dog", isChecked: false),
        ChecklistItem("Brush my teeth", isChecked: true),
        ChecklistItem("Learn iOS development", isChecked: false),
        ChecklistItem("Soccer practice", isChecked: false),
        ChecklistItem("Eat ice cream", isChecked: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        configureLabel(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.isChecked.toggle()
            configureCheckmark(for: cell,  with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - Private methods

private extension ChecklistsViewController {
    
    @IBAction func addItem() {
        items.append(ChecklistItem("I am a new row", isChecked: false))
        let indexPath = IndexPath(row: items.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func configureLabel(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        cell.accessoryType = item.isChecked ? .checkmark : .none
    }
}
