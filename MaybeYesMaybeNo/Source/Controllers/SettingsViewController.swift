//
//  SettingsViewController.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/22/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: BaseViewController {

    private var viewModel: SettingsViewModel!
    @IBOutlet weak private var tableView: UITableView!

    func attach(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cofigureNavigationBar()
    }

    private func cofigureNavigationBar() {
        tableView.backgroundColor = Asset.background.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: L10n.BarButtonItem.Title.add,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addAnswer))
    }

    @objc private func addAnswer() {
        presentAlertForNewAnswer()
    }

    private func presentAlertForNewAnswer() {

        let alertController = UIAlertController(title: L10n.AlertController.title,
                                                message: L10n.AlertController.message,
                                                preferredStyle: .alert)

        var alertTextField: UITextField!
        alertController.addTextField { textField in
            alertTextField = textField
            textField.placeholder = L10n.AlertController.TextField.placeholder
            textField.autocorrectionType = .yes
        }

        let saveAction = UIAlertAction(title: L10n.AlertController.Action.save, style: .default) { [weak self] _ in
            guard let text = alertTextField.text, !text.isEmpty else { return }
            self?.viewModel.addItem(with: text)
            self?.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: L10n.AlertController.Action.cancel, style: .destructive, handler: nil)

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
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
        cell.textLabel?.text = item.text
        cell.textLabel?.textColor = Asset.text.color 

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
