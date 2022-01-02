//
//  LinkBankViewController.swift
//  Assignment
//
//  Created by Shreyas Rajapurkar on 01/01/22.
//

import Foundation
import UIKit

class LinkBankViewController: UIViewController, UITextFieldDelegate, LinkBankViewProtocol {

    // MARK: - Properties

    let bankTextField = UITextField()
    let addAccountButton = UIButton()
    let proceedButton = UIButton()
    let viewModel: LinkBankViewModel
    var bankName: String?

    // MARK: - Static constants

    static let buttonColor = UIColor.systemGreen

    // MARK: - Initialization

    init(viewModel: LinkBankViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        bankTextField.delegate = self
        viewModel.delegate = self

        setupViewHierarchy()
        setupConstraints()
        setupUI()
    }

    // MARK: - Private methods

    private func setupViewHierarchy() {
        view.addSubview(bankTextField)
        view.addSubview(addAccountButton)
        view.addSubview(proceedButton)
    }

    private func setupUI() {
        view.backgroundColor = UIColor.lightGray

        // Bank text field
        bankTextField.backgroundColor = UIColor.white
        bankTextField.placeholder = "Enter your bank's name"
        bankTextField.addTarget(self, action: #selector(textFieldEditing), for: .editingChanged)
        stylizeBorder(view: bankTextField)

        // Add account button
        addAccountButton.backgroundColor = LinkBankViewController.buttonColor.withAlphaComponent(0.2)
        addAccountButton.setTitle("Add", for: .normal)
        addAccountButton.isUserInteractionEnabled = false
        addAccountButton.addTarget(self, action: #selector(addAccountTapped), for: .touchUpInside)
        stylizeBorder(view: addAccountButton)

        // Proceed button
        proceedButton.backgroundColor = LinkBankViewController.buttonColor.withAlphaComponent(0.2)
        proceedButton.isUserInteractionEnabled = false
        proceedButton.setTitle("Proceed to payment", for: .normal)
        proceedButton.addTarget(self, action: #selector(proceedButtonTapped), for: .touchUpInside)
        stylizeBorder(view: proceedButton)
    }

    private func setupConstraints() {
        bankTextField.translatesAutoresizingMaskIntoConstraints = false
        addAccountButton.translatesAutoresizingMaskIntoConstraints = false
        proceedButton.translatesAutoresizingMaskIntoConstraints = false

        var constraints = [NSLayoutConstraint]()

        // Bank text field
        constraints.append(bankTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50))
        constraints.append(bankTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(bankTextField.heightAnchor.constraint(equalToConstant: 40))

        // Add account button
        constraints.append(addAccountButton.leadingAnchor.constraint(equalTo: bankTextField.trailingAnchor, constant: 20))
        constraints.append(addAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10))
        constraints.append(addAccountButton.topAnchor.constraint(equalTo: bankTextField.topAnchor))
        constraints.append(addAccountButton.heightAnchor.constraint(equalTo: bankTextField.heightAnchor))
        constraints.append(addAccountButton.widthAnchor.constraint(equalToConstant: 60))

        // Proceed button
        constraints.append(proceedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(proceedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        constraints.append(proceedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20))
        constraints.append(proceedButton.heightAnchor.constraint(equalToConstant: 60))
        NSLayoutConstraint.activate(constraints)
    }

    @objc
    func addAccountTapped() {
        proceedButton.backgroundColor = proceedButton.backgroundColor?.withAlphaComponent(1)
        proceedButton.isUserInteractionEnabled = true
        bankName = bankTextField.text
    }

    @objc
    func proceedButtonTapped() {
        guard let bankName = bankTextField.text else {
            assert(true, "Proceed button should not be active if a bank name is not available")
            return
        }

        viewModel.saveBankCredentials(bankName: bankName)

        let homeViewController = HomeViewController(viewModel: HomeViewModel(), bankName: bankName)
        homeViewController.modalPresentationStyle = .fullScreen
        present(homeViewController, animated: true, completion: nil)
    }

    private func stylizeBorder(view: UIView) {
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 10.0
    }

    // MARK: - UITextFieldDelegate

    @objc
    func textFieldEditing() {
        viewModel.handleTextFieldInput(textField: bankTextField)
    }

    // MARK: - LinkBankViewProtocol

    func enableAddAccountButton(shouldEnable: Bool) {
        if shouldEnable {
            addAccountButton.backgroundColor = LinkBankViewController.buttonColor.withAlphaComponent(1)
            addAccountButton.isUserInteractionEnabled = true
        } else {
            addAccountButton.backgroundColor = LinkBankViewController.buttonColor.withAlphaComponent(0.2)
            addAccountButton.isUserInteractionEnabled = false
        }
    }
}
