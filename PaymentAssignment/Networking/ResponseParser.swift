//
//  ResponseParser.swift
//  Assignment
//
//  Created by Shreyas Rajapurkar on 01/01/22.
//

class ResponseParser {
    public static func parseStoresData(response: [Dictionary<String, Any>]) -> [Store] {
        if response.count == 0 {
            return []
        }

        var storeModels = [Store]()
        for store in response {
            let name = store["name"] as? String
            let imageURL = store["logo"] as? String
            let ID = store["id"] as? String
            let contact = store["contact"] as? String
            storeModels.append(Store(name: name, imageURL: imageURL, ID: ID, contact: contact))
        }

        return storeModels
    }

    /**
     Unused currently, as we only need to check if the response was a success to verify if the payment was completed.
     */
    public static func parsePaymentData(response: [Dictionary<String, Any>]) -> Payment {
        return Payment(referenceID: "1", timeStamp: "1", ID: "1", amount: 1)
    }
}
