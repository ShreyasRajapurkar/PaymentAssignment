//
//  PaymentViewModel.swift
//  Assignment
//
//  Created by Shreyas Rajapurkar on 02/01/22.
//

import Foundation

class PaymentViewModel {
    public func initiatePayment(completion: @escaping (PaymentStatus) -> Void) {
        NetworkingHelper.initiatePayment(completion: completion)
    }
}
