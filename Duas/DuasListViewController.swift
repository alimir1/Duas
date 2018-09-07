//
//  DuasListViewController.swift
//  Duas
//
//  Created by Ishraq on 9/6/18.
//  Copyright © 2018 Duas. All rights reserved.
//

import UIKit

protocol DuaSelectionDelegate: class {
    func didSelectDua(_ dua: Dua)
}

class DuasListViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    var duas = [[Dua]]()
    var categories = [String]()
    var delegate: DuaSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let duaGroup = Dictionary(grouping: allDuas) { String($0.category) }
        categories = duaGroup.keys.map {String($0)}
        for category in categories {
            if let duas = duaGroup[category] {
                self.duas.append(duas)
            }
        }
        
    }
    
    // MARK: - Table view setup

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return duas[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "duaCell", for: indexPath)
        let dua = duas[indexPath.section][indexPath.row]
        cell.textLabel?.text = dua.englishName
        cell.detailTextLabel?.text = dua.arabicName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        _ = navigationController?.popViewController(animated: true)
        delegate?.didSelectDua(duas[indexPath.section][indexPath.row])
    }
    
}
