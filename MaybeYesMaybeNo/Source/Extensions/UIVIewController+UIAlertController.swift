//
//  UIVIewController+UIAlertController.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/27/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addAlertForNewAnswer(with: UITableView? = nil) {
        
        let alertController = UIAlertController(title: "New Answer", message: "Please fill in the field", preferredStyle: .alert)
        
        var alertTextField: UITextField!
        alertController.addTextField { textField in
            alertTextField = textField
            textField.placeholder = "New Answer"
            textField.autocorrectionType = .yes
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            guard let text = alertTextField.text , !text.isEmpty else { return }
            
            DataBaseManager.add(text: text)
            with?.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
