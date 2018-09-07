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
    
    var duas = [Dua]()
    var delegate: DuaSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        duas = allDuas
    }
    
    // MARK: - Table view setup

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return duas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "duaCell", for: indexPath)
        let dua = duas[indexPath.row]
        cell.textLabel?.text = dua.englishName
        cell.detailTextLabel?.text = dua.arabicName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        _ = navigationController?.popViewController(animated: true)
        delegate?.didSelectDua(duas[indexPath.row])
    }
    
}
