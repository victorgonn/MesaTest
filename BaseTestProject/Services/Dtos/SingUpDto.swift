//
//  SingUpDto.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 02/12/20.
//

import Foundation

struct SingUpRequest: Codable {
    var name: String
    var email: String
    var password: String
}
