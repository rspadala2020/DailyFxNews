//
//  NewsCollectionViewDataSource.swift
//  dailyFxNews
//
//  Created by raja padala on 06/11/21.
//

import Foundation
import UIKit

class NewsCollectionViewDataSource<CELL : UICollectionViewCell,T: Codable> : NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    private var cellIdentifier : String!
    private var detailListviewModel: DetailListviewModel!
    private var listItems: [String] = ["Top news", "Technical analysis", "Special report"]
    private var items : [T]!
    var configureCell : (CELL, T, String) -> () = {_,_,_ in }
    var navigateTodetailsListScreen: ((_ viewmodel: DetailListviewModel) -> ())?
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T, String) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeScreenCell", for: indexPath) as! CELL
        let item = self.listItems[indexPath.row]
        if items.isEmpty == false, let serviceItem = items.first {
            self.configureCell(cell, serviceItem, item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if items.isEmpty == false, let serviceItem: DailyFxNews = items.first as? DailyFxNews {
            self.detailListviewModel =  DetailListviewModel()
            switch indexPath.row {
            case 0:
                self.detailListviewModel.newsTitle = listItems[indexPath.row]
                self.detailListviewModel.newsData = serviceItem.topNews
                break
            case 1:
                self.detailListviewModel.newsTitle = listItems[indexPath.row]
                self.detailListviewModel.newsData = serviceItem.technicalAnalysis
            case 2:
                self.detailListviewModel.newsTitle = listItems[indexPath.row]
                self.detailListviewModel.newsData = serviceItem.specialReport
            default:
                break
            }
            self.navigateTodetailsListScreen!(self.detailListviewModel)
        }
    }

}
