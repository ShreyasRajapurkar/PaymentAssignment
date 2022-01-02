//
//  LinkBankViewModel.swift
//  Assignment
//
//  Created by Shreyas Rajapurkar on 01/01/22.
//

import Foundation
import UIKit

protocol LinkBankViewProtocol: AnyObject {
    func enableAddAccountButton(shouldEnable: Bool)
}

class LinkBankViewModel {

    weak var delegate: LinkBankViewProtocol?
    
    func handleTextFieldInput(textField: UITextField) {
        if let text = textField.text {
            if text.isEmpty {
                delegate?.enableAddAccountButton(shouldEnable: false)
            } else {
                delegate?.enableAddAccountButton(shouldEnable: true)
            }
        }
    }

    func saveBankCredentials(bankName: String) {
        UserDefaults.standard.set(bankName, forKey: "UserBankName")
    }
}
