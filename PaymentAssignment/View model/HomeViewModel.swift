//
//  HomeViewModel.swift
//  Assignment
//
//  Created by Shreyas Rajapurkar on 30/12/21.
//

/**
 This protocol handles the callback for when the stores are fetched, and is responsible for updating the UI
 **/
protocol UpdateStoresViewProtocol: AnyObject {
    func fetchedStoresDataSuccess()
    func fetchedStoresDataFailure()
}

public class HomeViewModel {

    public init() {
        
    }

    weak var delegate: UpdateStoresViewProtocol?

    var stores = [Store]() {
        didSet {
            delegate?.fetchedStoresDataSuccess()
        }
    }

    func fetchStores(delegate: UpdateStoresViewProtocol?) {
        self.delegate = delegate
        NetworkingHelper.fetchStores(completion: { [weak self] stores in
            self?.stores = stores
        }, delegate: delegate)
    }
}
