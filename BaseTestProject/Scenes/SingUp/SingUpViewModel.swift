//
//  SingUpViewModel.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 02/12/20.
//

import Foundation
import Promises

class SingUpViewModel {
    var singUpRequest: SingUpRequest = SingUpRequest(name: "", email: "", password: "")
    var actualStep: SingUpFlux = .name
    
    func createAccount() -> Promise<LoginResponse> {
        return ServiceApiClient.createAccount(request: self.singUpRequest)
    }
}
