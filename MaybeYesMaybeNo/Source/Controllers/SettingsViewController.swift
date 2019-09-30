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

    var viewModel: SettingsViewModel!
    @IBOutlet weak private var tableView: UITableView!

    func attach(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cofigureNavigationBar()
    }

    private func cofigureNavigationBar() {
        tableView.backgroundColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: L10n.BarButtonItem.Title.add,
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
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath)
        cell.backgroundColor = .clear
        let items = viewModel.dataBaseStorage()
        let item = items[indexPath.row]
        cell.textLabel?.text = item.answerDefault
        cell.textLabel?.textColor = UIColor.white

        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editingRows = viewModel.dataBaseStorage()
        let editingRow = editingRows[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: L10n.RowAction.delete) { [weak self] _, _ in
            self?.viewModel.removeItem(from: editingRow)
            tableView.reloadData()
        }
        return [deleteAction]
    }
}
