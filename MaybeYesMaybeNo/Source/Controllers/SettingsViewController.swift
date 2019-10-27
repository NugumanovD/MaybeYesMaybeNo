//
//  SettingsViewController.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/22/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SettingsViewController: BaseViewController {

    private var viewModel: SettingsViewModel
    private let tableView = UITableView()
    var answersHistory = [PresentableAnswer]()

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        tabBarItem.title = L10n.TabbarItem.Title.history
        tabBarItem.image = Asset.list.image
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func attach(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewCell()
        cofigureNavigationBar()
        configureTableViewConstraints()
        navigationItem.title = L10n.TabbarItem.Title.history
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        answersHistory = viewModel.dataBaseStorage()
        tableView.reloadData()
    }

    private func registerTableViewCell() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Cell.identifier)
    }

    private func cofigureNavigationBar() {
        tableView.backgroundColor = Asset.background.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: L10n.BarButtonItem.Title.add,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addAnswer))
    }

    func configureTableViewConstraints() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
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
            guard let text = alertTextField.text, !text.isEmpty, let self = self else { return }
            let date = self.viewModel.convert(date: Date())
            let savingItem = PresentableAnswer(text: text, timeStamp: Date(), identifier: "")
            self.viewModel.addItem(with: savingItem)
            DispatchQueue.main.async {
                self.answersHistory = self.viewModel.dataBaseStorage()
                self.tableView.reloadData()
            }
        }

        let cancelAction = UIAlertAction(title: L10n.AlertController.Action.cancel, style: .destructive, handler: nil)

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension SettingsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answersHistory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath)
        let item = answersHistory[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.text = item.text
        cell.textLabel?.textColor = Asset.text.color
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let item = answersHistory.remove(at: indexPath.row)
            viewModel.removeItem(item)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}
