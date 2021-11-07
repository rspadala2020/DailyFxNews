//
//  DetailListDataSource.swift
//  dailyFxNews
//
//  Created by raja padala on 07/11/21.
//

import Foundation
import UIKit

class DetailListDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource, UITableViewDelegate {
        
    private var cellIdentifier : String!
    private var items : [T]!
    var configureDetailsCell : (CELL, T) -> () = {_,_ in }
    var navigatetowebScreen: ((_ url: URL) -> ())?
    init(cellIdentifier : String, items : [T], configureDetailsCell : @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureDetailsCell = configureDetailsCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailListCell", for: indexPath) as! CELL
        let item = self.items[indexPath.row]
            self.configureDetailsCell(cell, item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item: SpecialReport = self.items[indexPath.row] as? SpecialReport {
            if let url = item.url, let finalUrl: URL = URL(string: url) {
                navigatetowebScreen!(finalUrl)
            }
        }
    }
    
}
