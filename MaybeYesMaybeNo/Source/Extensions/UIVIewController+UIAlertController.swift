//
//  UIVIewController+UIAlertController.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/27/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import UIKit

extension UIViewController {

    func addAlertForNewAnswer(with: UITableView? = nil, storage: DataBaseManager) {

        let alertController = UIAlertController(title: L10n.AlertController.title, message:L10n.AlertController.message, preferredStyle: .alert)

        var alertTextField: UITextField!
        alertController.addTextField { textField in
            alertTextField = textField
            textField.placeholder = L10n.AlertController.TextField.placeholder
            textField.autocorrectionType = .yes
        }

        let saveAction = UIAlertAction(title: L10n.AlertController.Action.save, style: .default) { _ in
            guard let text = alertTextField.text, !text.isEmpty else { return }

            storage.add(text: text)
            with?.reloadData()
        }

        let cancelAction = UIAlertAction(title: L10n.AlertController.Action.cancel, style: .destructive, handler: nil)

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}
