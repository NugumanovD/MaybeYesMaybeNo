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
    
    func cofigureNavigationBar() {
        tableView.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addAnswer))
    }
    
    @objc func addAnswer() {
        addAlertForNewAnswer()
    }
    
    
    func addAlertForNewAnswer() {
        
        let alertController = UIAlertController(title: "New Answer", message: "Please fill in the field", preferredStyle: .alert)
        
        var alertTextField: UITextField!
        alertController.addTextField { textField in
            alertTextField = textField
            textField.placeholder = "New Answer"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            guard let text = alertTextField.text , !text.isEmpty else { return }
            
            DataBaseManager.add(text: text, in: self.realm)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
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
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item.answerDefault
        
        return cell
    }
    
    
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editingRow = items[indexPath.row]
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { _,_ in
            try! self.realm.write {
                self.realm.delete(editingRow)
                tableView.reloadData()
            }
        }
        return [deleteAction]
    }
}
