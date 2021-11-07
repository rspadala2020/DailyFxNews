//
//  DetailListviewModel.swift
//  dailyFxNews
//
//  Created by raja padala on 07/11/21.
//

import Foundation

class DetailListviewModel: NSObject {
    var newsData : [SpecialReport]?
    var newsTitle: String?
    var newsDetailListViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
    }
    
}
