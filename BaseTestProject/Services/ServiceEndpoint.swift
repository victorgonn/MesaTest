//
//  ServicesEndPoints.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 30/11/20.
//

import Foundation
import Alamofire

enum ServiceEndpoint: ApiConfiguration {
    case login(request: LoginRequest)
    case createAccount(request: SingUpRequest)
    case getNews(request: NewsRequest)
    case getHightlights

    
    var baseUrl: String {
        return EnvironmentUtils.baseUrl
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .createAccount:
            return .post
        case .getNews, .getHightlights:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/v1/client/auth/signin"
        case .createAccount:
            return "/v1/client/auth/signup"
        case .getNews:
            return "/v1/client/news"
        case .getHightlights:
            return "/v1/client/news/highlights"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getNews(let request):
            var paramenters : [String : Any] = [String : Any]()
            paramenters.updateValue(request.current_page, forKey: "current_page")
            paramenters.updateValue(request.per_page, forKey: "per_page")
            
            if request.published_at.isEmpty {
                paramenters.updateValue(request.published_at, forKey: "published_at")
            }
            return paramenters
        default:
            return nil
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .login(let request):
            return try? JSONEncoder().encode(request)
        case .createAccount(let request):
            return try? JSONEncoder().encode(request)
        default:
            return nil
        }
        
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getNews, .getHightlights:
            return ["Authorization": "Bearer \(UserDefaultsUtils.getAccessToken() ?? "")"]
        default:
            return nil
        }
    }
}
