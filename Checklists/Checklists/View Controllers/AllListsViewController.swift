//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Dunja Acimovic on 05.04.2021..
//

import UIKit

class AllListsViewController: UITableViewController {
    let cellIdentifier = "ChecklistCell"
    var dataModel: DataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.delegate = self
        
        let index = dataModel.indexOfSelectedChecklist
        if index >= 0 && index < dataModel.lists.count {
            let checklist = dataModel.lists[index]
            performSegue(withIdentifier: "ShowChecklist", sender: checklist)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destination as! ChecklistViewController // type cast
            controller.checklist = sender as? Checklist // also type cast, but if it cannot be a Checklist send nil
        } else if segue.identifier == "AddChecklist" {
            let controller = segue.destination as! ListDetailViewController
            controller.delegate = self
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel!.text = dataModel.lists[indexPath.row].name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataModel.indexOfSelectedChecklist = indexPath.row
        performSegue(withIdentifier: "ShowChecklist", sender: dataModel.lists[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.lists.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController // it can be force unwrapped because...
        controller.delegate = self                                                                                                      // self was instantieted from storyboard
        controller.checklistToEdit = dataModel.lists[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - List Detail View Controller Delegate
extension AllListsViewController: ListDetailViewControllerDelegate {
    
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
        dataModel.lists.append(checklist)
        let indexPath = IndexPath(row: dataModel.lists.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
        if let index = dataModel.lists.firstIndex(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Navigation Controller Delegate
extension AllListsViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController === self { dataModel.indexOfSelectedChecklist = -1 } // === is checking whether two variables refer to the exact same object
    }
}

