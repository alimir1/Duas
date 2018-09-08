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

class DuasListViewController: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var duas = [[Dua]]()
    var categories = [String]()
    var delegate: DuaSelectionDelegate?
    
    var duasFromDatabase = [Dua]()
    var selectedDua: Dua?
    
    var _duas = [Dua]() {
        didSet {
            let duaHelper = categoryDuaHelper(from: _duas)
            categories = duaHelper.0
            duas = duaHelper.1
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        duasFromDatabase = allDuas
        _duas = duasFromDatabase
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Duas"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.backgroundColor = ThemeManager.currentTheme.mainColor == .black ? .black : .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let dua = selectedDua {
            delegate?.didSelectDua(dua)
        }
    }
    
    func categoryDuaHelper(from duas: [Dua]) -> ([String], [[Dua]]) {
        let duaGroup = Dictionary(grouping: duas) { String($0.category) }
        let categories = duaGroup.keys.map {String($0)}
        var retDua = [[Dua]]()
        for category in categories {
            if let _duas = duaGroup[category] {
                retDua.append(_duas)
            }
        }
        return (categories, retDua)
    }
    
    // MARK: - Search
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchTerm = searchController.searchBar.text {
            if searchTerm != "" && !searchTerm.trimmingCharacters(in: .whitespaces).isEmpty {
                _duas = getDuas(for: searchTerm)
            } else {
                _duas = duasFromDatabase
            }
        }
    }
    
    func getDuas(for term: String) -> [Dua] {
        var searchDuas = Set<Dua>()
        let term = term.lowercased()

        for dua in duasFromDatabase {
            
            let arabicName = dua.arabicName.lowercased().components(separatedBy: " ")
            let category = dua.category.lowercased().components(separatedBy: " ")
            let englishName = dua.englishName.lowercased().components(separatedBy: " ")
            
            arabicName.forEach { (word) in
                if word.hasPrefix(term) {
                    searchDuas.insert(dua)
                }
            }
            
            category.forEach { (word) in
                if word.hasPrefix(term) {
                    searchDuas.insert(dua)
                }
            }
            
            englishName.forEach { (word) in
                if word.hasPrefix(term) {
                    searchDuas.insert(dua)
                }
            }
        }
        
        return Array<Dua>(searchDuas)
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
        cell.backgroundColor = ThemeManager.currentTheme.secondaryColor
        cell.textLabel?.textColor = ThemeManager.currentTheme.textColor
        cell.detailTextLabel?.textColor = ThemeManager.currentTheme.textColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDua = duas[indexPath.section][indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        _ = navigationController?.popViewController(animated: true)
    }
    
}
