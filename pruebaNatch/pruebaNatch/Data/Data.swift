//
//  DAta.swift
//  pruebaNatch
//
//  Created by Angel Olvera on 21/06/21.
//

import Foundation

struct UserResponse: Decodable {
    let colors: [String]
    let questions: [Questions]
}

struct Questions: Decodable {
    let total: Int
    let text: String
    let chartData: [ChartData]
}

struct ChartData: Decodable {
    let text: String
    let percetnage: Int
}
