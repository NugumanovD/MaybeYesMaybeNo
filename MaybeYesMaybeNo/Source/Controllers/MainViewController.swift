//
//  ViewController.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/21/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    private let requestManager = NetworkManager()
    
    @IBOutlet private var answerLabel: UILabel!
    @IBOutlet private var settingsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSettingsButton()
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            cofigureAnswer()
        }
    }
    
    @IBAction func presentSettingsScreen(_ sender: UIButton) {
        navigationController?.pushViewController(transitionToController(with: Screen.settingsView), animated: true) 
    }
    
    func cofigureAnswer() {
        requestManager.fetchAnswer { [weak self] (result, error) in
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.answerLabel.text = "Lol!"
                }
                return
            }
            guard let answer = result?.magic.answer else { return }
            
            DispatchQueue.main.async {
                self?.answerLabel.text = answer
            }
        }
    }
    
    func configureSettingsButton() {
        settingsButton.clipsToBounds = true
        settingsButton.layer.cornerRadius = settingsButton.bounds.size.width / 2
        settingsButton.backgroundColor = .clear
        settingsButton.setImage(UIImage(named: "settings"), for: .normal)
    }
    
    
    
}

