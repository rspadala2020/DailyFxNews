//
//  DetailListViewController.swift
//  dailyFxNews
//
//  Created by raja padala on 07/11/21.
//

import UIKit

class DetailListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var detailListviewModel : DetailListviewModel?
    private var dataSource : DetailListDataSource<DetailListCell,SpecialReport>!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.navigationItem.title = detailListviewModel?.newsTitle ?? ""
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeContentTitle = detailListviewModel?.newsTitle ?? ""
        callToViewModelForUIUpdate()
        self.detailListviewModel?.newsDetailListViewModelToController()

    }
    
    func callToViewModelForUIUpdate() {
        
        self.detailListviewModel?.newsDetailListViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        
        self.dataSource = DetailListDataSource(cellIdentifier: "DetailListCell", items: self.detailListviewModel?.newsData ?? [], configureDetailsCell: { (cell, details) in
            cell.newsTitle.text = details.title
            cell.newsDescription.text = details.specialReportDescription
            if let url = URL(string: details.headlineImageURL ?? "") {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async {
                        cell.newsImage.image = UIImage(data: data)
                    }
                }
                
                task.resume()
            }
        })
        
        self.dataSource.navigatetowebScreen = { [unowned self] finalUrl in
            self.navigateToWebViewController(url: finalUrl)
        }
        
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.delegate = self.dataSource
            self.tableView.reloadData()
        }
    }
    
    func navigateToWebViewController(url: URL) {
        let webViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        webViewController.finalUrl = url
        let navigationcontroller = UINavigationController(rootViewController: webViewController)
        navigationController?.modalPresentationStyle = UIDevice.current.userInterfaceIdiom == .pad ?  .formSheet : .fullScreen
        present(navigationcontroller, animated: true)
    }

}
