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
    var items: Results<DefaultAnswersModel>!
    private let dataBase = DataBaseManager()

    @IBOutlet weak private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        cofigureNavigationBar()
        items = realm.objects(DefaultAnswersModel.self)
    }

    private func cofigureNavigationBar() {
        tableView.backgroundColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: L10n.BarButtonItem.add,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addAnswer))
    }

    @objc func addAnswer() {
        addAlertForNewAnswer(with: tableView, storage: dataBase)
    }
}

extension SettingsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
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
        let deleteAction = UITableViewRowAction(style: .default, title: L10n.RowAction.delete) { _, _ in
            self.dataBase.delete(item: editingRow, in: self.realm)
            tableView.reloadData()
        }
        return [deleteAction]
    }
}
