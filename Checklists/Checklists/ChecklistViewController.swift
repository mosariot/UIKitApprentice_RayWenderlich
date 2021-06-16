//
//  ChecklistViewController.swift
//  Checklists
//
//  Created by Александр Воробьев on 15.01.2021.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewConrollerDelegate {
    
    var checklist: Checklist!
    
    let cellIdentifier = "ChecklistItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = checklist.name
    }
    
    //MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if let tmp = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell = tmp
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        let item = checklist.items[indexPath.row]
        
        cell.textLabel?.text = item.text
        cell.accessoryType = .detailDisclosureButton
        
        configureCheckmark(for: cell, with: item)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        let dueDate = formatter.string(from: item.dueDate)
        cell.detailTextLabel?.text = item.shouldRemind ? "Due date: " + dueDate : nil
        cell.detailTextLabel?.textColor = .secondaryLabel
        
        return cell
    }
    
    //MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = checklist.items[indexPath.row]
            item.checked.toggle()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        checklist.items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "ItemDetailViewController") as! ItemDetailViewController
        controller.delegate = self
        
        let item = checklist.items[indexPath.row]
        controller.itemToEdit = item
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        cell.textLabel?.text = item.text
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        if item.checked {
            cell.imageView?.image = UIImage(systemName: "checkmark")
        } else {
            cell.imageView?.image = UIImage(systemName: "checkmark")?.withTintColor(.clear, renderingMode: .alwaysOriginal)
        }
    }
    
    //MARK: - ItemDetailViewController Delegate
    
    func itemDetailViewControllerDidCancel(_ controller: UIViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: UIViewController, didFinishAdding item: ChecklistItem) {
        checklist.items.append(item)
        checklist.sortItems()
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: UIViewController, didFinishEditing item: ChecklistItem) {
        checklist.sortItems()
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
}
