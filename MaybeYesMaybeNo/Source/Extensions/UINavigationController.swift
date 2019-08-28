//
//  UINavigationController.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/28/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
