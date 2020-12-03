//
//  ServiceApiClient.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 30/11/20.
//

import Foundation
import Promises
import Alamofire

class ServiceApiClient: ApiClient {
    static func doLogin(request: LoginRequest) -> Promise<LoginResponse> {
        return performRequestAsync(route: ServiceEndpoint.login(request: request))
    }
    
    static func createAccount(request: SingUpRequest) -> Promise<LoginResponse> {
        return performRequestAsync(route: ServiceEndpoint.createAccount(request: request))
    }
    
    static func getNews(request: NewsRequest) -> Promise<NewsResponse> {
        return performRequestAsync(route: ServiceEndpoint.getNews(request: request))
    }
    
    static func getHightLights() -> Promise<NewsResponse> {
        return performRequestAsync(route: ServiceEndpoint.getHightlights)
    }
}

