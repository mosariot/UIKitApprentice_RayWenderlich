//
//  Checklist.swift
//  Checklists
//
//  Created by Александр Воробьев on 26.01.2021.
//

import Foundation

class Checklist: NSObject, Codable {
    var name = ""
    var items: [ChecklistItem] = []
    var iconName = "Appointments"
    
    init(name: String, iconName: String = "Folder") {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    func countUncheckedItems() -> Int {
        items.reduce(0) { cnt, item in
            cnt + (item.checked ? 0 : 1)
        }
    }
    
    func sortItems() {
        items.sort{ $0.dueDate < $1.dueDate }
    }
}
