//
//  NetworkingHelper.swift
//  Assignment
//
//  Created by Shreyas Rajapurkar on 01/01/22.
//

import Foundation

class NetworkingHelper {
    public static func fetchStores(completion: @escaping ([Store]) -> Void, delegate: UpdateStoresViewProtocol?) {
        let url = URL(string: "https://run.mocky.io/v3/f082d1e7-362c-4073-a3c2-ec33851224e9")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                delegate?.fetchedStoresDataFailure()
                return
            }

            do {
                if let data = data,
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [Dictionary<String, Any>] {
                    let stores = ResponseParser.parseStoresData(response: jsonObject)
                    completion(stores)
                }
            } catch {
                print("JSONSerialization error:", error)
            }
        }

        dataTask.resume()
    }

    public static func initiatePayment(completion: @escaping (PaymentStatus) -> Void) {
        let url = URL(string: "https://run.mocky.io/v3/6cdc43f3-fc7f-4db0-9d0d-51d9ceae2bb8")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 200 {
                completion(.success)
            } else {
                completion(.failure)
            }
        }

        dataTask.resume()
    }
}
