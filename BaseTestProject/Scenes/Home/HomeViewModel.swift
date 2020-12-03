//
//  HomeViewModel.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 30/11/20.
//

import Foundation
import Promises

class HomeViewModel {
    var hNews: [News] = []
    var news: [News] = []
    var pageIndex: Int = 0
    var size: Int = 50
    var maxPage: Int?
    
    func getHNews() -> Promise<NewsResponse> {
        return ServiceApiClient.getHightLights()
    }
    
    func getNews() -> Promise<NewsResponse> {
        pageIndex += 1
        debugPrint("carregando news da pagina:", pageIndex)
        let request = NewsRequest(current_page: pageIndex, per_page: size, published_at: "")
        return ServiceApiClient.getNews(request: request)
    }
}
