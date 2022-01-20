//
//  UIViewController+ModalAlerts.swift
//  ChefCraftApp
//
//  Created by Work on 18.01.2022.
//

import UIKit
import RxSwift
import Swinject

extension UIViewController {
    
    func showPermissionDeclineWarning(with message: String) {
        let alert = UIAlertController(title: "Увага", message: message, preferredStyle: .alert)
        let enableBtn = UIAlertAction(title: "Налаштування", style: .default, handler: { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        let cancelBtn = UIAlertAction(
            title: "Скасувати",
            style: .cancel,
            handler: nil
        )
        alert.addAction(cancelBtn)
        alert.addAction(enableBtn)
        self.present(alert, animated: true)
    }
}
