//
//  MenuViewController.swift
//  StoreSearch
//
//  Created by Александр Воробьев on 28.06.2021.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func menuViewControllerSendMail(_ controller: MenuViewController)
}

class MenuViewController: UITableViewController {

    weak var delegate: MenuViewControllerDelegate?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            delegate?.menuViewControllerSendMail(self)
        }
    }
}

