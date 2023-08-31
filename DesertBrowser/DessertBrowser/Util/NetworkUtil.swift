//
//  NetworkUtil.swift
//  IDesserts
//
//  Created by Jesus Garcia ibarra on 30/08/23.
//

import Foundation

func fetch<T:Codable>(from urlString: String, onSuccess: @MainActor @escaping (T) -> Void) async -> Void { //Fetch data from the API and decode the data into a swift codable object
    guard let url = URL(string: urlString) else {
        print("Invalid URL: \(urlString)")
        return
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)    //Fetch data from the URL
        let decodedData = try JSONDecoder().decode(T.self, from: data) //Data decoded into a swift codable object
    
        await onSuccess(decodedData)  //If decoding was successful
    } catch {
        print(error.localizedDescription)   //If decoding fails
    }
}
