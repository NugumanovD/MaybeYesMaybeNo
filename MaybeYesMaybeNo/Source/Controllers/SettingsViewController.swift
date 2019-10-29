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
import RxSwift
import RxCocoa
import RxDataSources

class SettingsViewController: BaseViewController, UITableViewDelegate {

    // MARK: - Public Properties

    var dataSource: RxTableViewSectionedAnimatedDataSource<SectionOfCustomData>?

    // MARK: - Private Properties

    private var viewModel: SettingsViewModel
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()

    // MARK: - Init

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
        registerTableViewCell()
        setupDataSource()
        setupDelegateTableView()
        cofigureNavigationBar()
        configureTableViewConstraints()
        navigationItem.title = L10n.TabbarItem.Title.history
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.dataBaseStorage()
    }

    private func setupDataSource() {
        dataSource = RxTableViewSectionedAnimatedDataSource<SectionOfCustomData>(
            configureCell: { _, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath)
                cell.textLabel?.text = item.text
                return cell
        }, canEditRowAtIndexPath: { _, _ in
            return true
        })
        viewModel.allDataStorage
            .asObservable()
            .map { [SectionOfCustomData(header: "", items: $0)]}
            .bind(to: tableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
    }

    private func setupDelegateTableView() {
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        tableView.rx.itemDeleted
            .subscribe(onNext: { indexPath in
                guard let deletingItem = try? self.viewModel.allDataStorage.value() else { return }
                let item = deletingItem[indexPath.row]
                self.viewModel.removeItem(indexPath)
                self.viewModel.deletingEvent.onNext(item)
                print(indexPath)
            }).disposed(by: disposeBag)
    }

    private func registerTableViewCell() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Cell.identifier)
    }

    private func cofigureNavigationBar() {
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
            let savingItem = PresentableAnswer(text: text, timeStamp: Date(), identifier: "")
            self.viewModel.addItem(with: savingItem)
            DispatchQueue.main.async {
                self.viewModel.dataBaseStorage()
                self.tableView.reloadData()
            }
        }

        let cancelAction = UIAlertAction(title: L10n.AlertController.Action.cancel, style: .destructive, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
