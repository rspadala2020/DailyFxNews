//
//  NewsViewModel.swift
//  dailyFxNews
//
//  Created by raja padala on 06/11/21.
//

import Foundation

class NewsViewModel : NSObject {
    private var apiService : APIService<Decodable>!
    private(set) var newsData : DailyFxNews! {
        didSet {
            self.newsViewModelToController(nil)
        }
    }
    
    var newsViewModelToController : ((String?) -> ()) = {_ in }
    
    override init() {
        super.init()
        self.apiService =  APIService<Decodable>()
        callFuncToGetNewsData()
    }
    
    func callFuncToGetNewsData() {
        self.apiService.fetch(model: DailyFxNews.self, urlString: AppUrls.sourceUrl) { [weak self] model, error, errorCode in
            if let model = model {
                self?.newsData = model
            } else if let err = error {
                self?.newsViewModelToController(err)
            } else if errorCode != nil {
                self?.newsViewModelToController("Unknown error")
            }
        }
    }
}
