//
//  ViewController.swift
//  Assignment
//
//  Created by Shreyas Rajapurkar on 30/12/21.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UpdateStoresViewProtocol, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties

    let viewModel: HomeViewModel
    let bankName: String
    let failureLabel = UILabel()
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()

    // MARK: - Initialization
    
    init(viewModel: HomeViewModel, bankName: String) {
        self.viewModel = viewModel
        self.bankName = bankName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.lightGray
        viewModel.delegate = self

        setupFailureState()
        setupCollectionView()
        setupConstraints()
        viewModel.fetchStores(delegate: self)
    }

    // MARK: - Private methods

    private func setupCollectionView() {
        collectionView.register(StoreCell.self, forCellWithReuseIdentifier: "StoreCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }

    private func setupFailureState() {
        failureLabel.text = "Failed to fetch stores. Tap to try again."
        failureLabel.isHidden = true
        failureLabel.textColor = UIColor.red

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(retryStoresFetch))
        failureLabel.addGestureRecognizer(tapGestureRecognizer)
        failureLabel.isUserInteractionEnabled = true
        view.addSubview(failureLabel)
    }

    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        failureLabel.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()

        // Main collection view
        constraints.append(collectionView.leadingAnchor .constraint(equalTo: view.leadingAnchor, constant: 0))
        constraints.append(collectionView.topAnchor .constraint(equalTo: view.topAnchor, constant:20))
        constraints.append(collectionView.trailingAnchor .constraint(equalTo: view.trailingAnchor, constant: 0))
        constraints.append(collectionView.bottomAnchor .constraint(equalTo: view.bottomAnchor, constant: 0))

        // Failure label
        constraints.append(failureLabel.centerXAnchor .constraint(equalTo: view.centerXAnchor))
        constraints.append(failureLabel.centerYAnchor .constraint(equalTo: view.centerYAnchor))

        NSLayoutConstraint.activate(constraints)
    }

    @objc
    func retryStoresFetch() {
        failureLabel.text = "Retrying"
        failureLabel.isUserInteractionEnabled = false
        viewModel.fetchStores(delegate: self)
    }

    private func showFailureState() {
        failureLabel.isHidden = false
        failureLabel.text = "Failed to fetch stores. Tap to try again."
        failureLabel.isUserInteractionEnabled = true
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoreCell", for: indexPath)
        let model = viewModel.stores[indexPath.row]
        (cell as? StoreCell)?.setup(model: model)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.stores[indexPath.row]
        let paymentViewController = PaymentViewController(
            viewModel: PaymentViewModel(),
            bankName: bankName,
            vendorName: model.name ?? "Store name unavailable")
        present(paymentViewController, animated: true, completion: nil)
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.stores.count;
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width - 20, height: 100)
    }

    // MARK: - UpdateStoresViewProtocol

    func fetchedStoresDataSuccess() {
        DispatchQueue.main.async {[weak self] in
            self?.collectionView.isHidden = false
            self?.failureLabel.isHidden = true
            self?.collectionView.reloadData()
        }
    }

    func fetchedStoresDataFailure() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.isHidden = true
            self?.showFailureState()
        }
    }
}

