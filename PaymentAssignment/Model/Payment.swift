//
//  Payment.swift
//  Assignment
//
//  Created by Shreyas Rajapurkar on 02/01/22.
//

import Foundation

class Payment {
    let referenceID: String?
    let timeStamp: String?
    let amount: NSNumber?

    init(referenceID: String?, timeStamp: String?, ID: String?, amount: NSNumber?) {
        self.referenceID = referenceID
        self.timeStamp = timeStamp
        self.amount = amount
    }
}
