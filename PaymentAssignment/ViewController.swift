//
//  ViewController.swift
//  Assignment
//
//  Created by Shreyas Rajapurkar on 30/12/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        // Check if the user has registered a bank already
        let bankNameOrNil = UserDefaults.standard.string(forKey: "UserBankName")

        // Show payment stores screen if bank name registered, otherwise open bank registration screen
        if let bankName = bankNameOrNil {
            let homeViewController = HomeViewController(viewModel: HomeViewModel(), bankName: bankName)
            homeViewController.modalPresentationStyle = .fullScreen
            present(homeViewController, animated: true, completion: nil)
            return
        }

        let linkBankViewController = LinkBankViewController(viewModel: LinkBankViewModel())
        linkBankViewController.modalPresentationStyle = .fullScreen
        present(linkBankViewController, animated: true, completion: nil)
    }

    
}

