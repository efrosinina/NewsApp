//
//  UIViewController+Ex.swift
//  NewsApp
//
//  Created by Елизавета Ефросинина on 24/05/2023.
//

import UIKit

extension UIViewController {
    func showAlert() {
        let alert = UIAlertController(title: "Networking error".localized,
                                      message: "No internet connection".localized,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK".localized, style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
