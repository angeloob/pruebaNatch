//
//  NetworkService.swift
//  pruebaNatch
//
//  Created by Angel Olvera on 21/06/21.
//

import Foundation
import Alamofire

final class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    private let kBaseUrl = "https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld"
    private let kStatusOk = 200...299
    
    func getUser(success: @escaping (_ user: UserResponse) -> (), failure: @escaping (_ error: Error?) -> ()){
        AF.request(kBaseUrl, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: UserResponse.self){ response in
            if let user = response.value{
                success(user)
            }else{
                failure(response.error)
            }
        }
    }
}
