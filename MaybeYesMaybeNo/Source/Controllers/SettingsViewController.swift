//
//  SettingsViewController.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/22/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class SettingsViewController: BaseViewController {
    
    let realm = try! Realm()
    var items: Results<DefaultAnswersList>!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cofigureNavigationBar()
        items = realm.objects(DefaultAnswersList.self)
    }
    
    private func cofigureNavigationBar() {
        tableView.backgroundColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addAnswer))
    }
    
    @objc func addAnswer() {
        addAlertForNewAnswer(with: tableView)
    }
    
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count != 0 {
            return items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath)
        cell.backgroundColor = .clear
        let item = items[indexPath.row]
        cell.textLabel?.text = item.answerDefault
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editingRow = items[indexPath.row]
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { _, _ in
            DataBaseManager.delete(item: editingRow, in: self.realm)
            tableView.reloadData()
        }
        return [deleteAction]
    }
}
