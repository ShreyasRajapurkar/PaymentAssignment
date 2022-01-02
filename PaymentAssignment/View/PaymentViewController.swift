//
//  PaymentViewController.swift
//  Assignment
//
//  Created by Shreyas Rajapurkar on 02/01/22.
//

import Foundation
import UIKit

enum PaymentStatus {
    case success
    case failure
}

class PaymentViewController: UIViewController {
    
    // MARK: - Properties

    let viewModel: PaymentViewModel
    let bankName: String
    let vendorName: String
    let transactionInformationLabel = UILabel()
    let initiatePaymentButton = UIButton()
    let statusLabel = UILabel()
    
    // MARK: - Static constants

    static let buttonColor = UIColor.systemGreen

    // MARK: - Initialization

    init(viewModel: PaymentViewModel, bankName: String, vendorName: String) {
        self.viewModel = viewModel
        self.bankName = bankName
        self.vendorName = vendorName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewHierarchy()
        setupUI()
        setupConstraints()
    }

    // MARK: - Private methods

    private func setupViewHierarchy() {
        view.addSubview(transactionInformationLabel)
        view.addSubview(initiatePaymentButton)
        view.addSubview(statusLabel)
    }

    private func setupUI() {
        view.backgroundColor = UIColor.white
        // Transaction info label
        transactionInformationLabel.numberOfLines = 0
        transactionInformationLabel.text = "Paying Rupees 250 to vendor \(vendorName) via \(bankName) bank account. Confirm payment."
        
        // Initiate payment button
        initiatePaymentButton.backgroundColor = PaymentViewController.buttonColor
        initiatePaymentButton.setTitle("Pay $250", for: .normal)
        initiatePaymentButton.layer.borderWidth = 1.0
        initiatePaymentButton.layer.cornerRadius = 10.0
        initiatePaymentButton.addTarget(self, action: #selector(initiatePayment), for: .touchUpInside)

        // Status label
        statusLabel.isHidden = true
    }

    private func setupConstraints() {
        transactionInformationLabel.translatesAutoresizingMaskIntoConstraints = false
        initiatePaymentButton.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false

        var constraints = [NSLayoutConstraint]()

        // Transaction info label
        constraints.append(transactionInformationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30))
        constraints.append(transactionInformationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30))
        constraints.append(transactionInformationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor))

        // Initiate payment button
        constraints.append(initiatePaymentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        constraints.append(initiatePaymentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        constraints.append(initiatePaymentButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20))
        constraints.append(initiatePaymentButton.heightAnchor.constraint(equalToConstant: 60))

        // Status label
        constraints.append(statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(statusLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20))
        NSLayoutConstraint.activate(constraints)
    }

    @objc
    func initiatePayment() {
        viewModel.initiatePayment { [weak self] paymentStatus in
            DispatchQueue.main.async {
                if paymentStatus == .success {
                    self?.statusLabel.text = "Payment completed successfully!"
                    self?.statusLabel.textColor = UIColor.green
                } else {
                    self?.statusLabel.text = "Payment failed"
                    self?.statusLabel.textColor = UIColor.red
                }
            }
        }

        initiatePaymentButton.isHidden = true
        statusLabel.isHidden = false
        statusLabel.text = "Payment in progress"
        statusLabel.textColor = UIColor.red
    }
}
