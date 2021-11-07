//
//  ViewController.swift
//  dailyFxNews
//
//  Created by raja padala on 06/11/21.
//

import UIKit

public class BaseViewController: UIViewController {
        
    @IBOutlet weak var collectionview: UICollectionView!
    private var newsViewModel : NewsViewModel!
    var dataSource : NewsCollectionViewDataSource<HomeScreenCell,DailyFxNews>!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 5/255, green: 117/255, blue: 230/255, alpha: 1)
        collectionview.contentInset = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        collectionview.backgroundColor = UIColor.clear
        self.navigationItem.title = "DailyFxNews"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeContentTitle = "DailyFxNews"
        callToViewModelForUIUpdate()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
    func callToViewModelForUIUpdate() {
        
        self.newsViewModel =  NewsViewModel()
        self.newsViewModel.newsViewModelToController = { error in
            if let err = error {
                DispatchQueue.main.async {
                    self.showAlert(title: err, message: "", actionTitle: "Ok")
                }
            } else {
                self.updateDataSource()
            }
        }
    }
    
    func updateDataSource(){
        
        self.dataSource = NewsCollectionViewDataSource(cellIdentifier: "HomeScreenCell", items: [self.newsViewModel.newsData], configureCell: { (cell, evm, titletxt) in
            print(evm)
            cell.titleLabel.text = titletxt
        })
        
        DispatchQueue.main.async {
            self.collectionview.dataSource = self.dataSource
            self.collectionview.delegate = self.dataSource
            self.collectionview.reloadData()
        }
        self.dataSource.navigateTodetailsListScreen = { [unowned self] viewmodel in
            self.navigateToDetailsListViewController(viewmodel: viewmodel)
        }
    }
    
    func navigateToDetailsListViewController(viewmodel: DetailListviewModel) {
        
        let detailListViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailListViewController") as! DetailListViewController
        detailListViewController.detailListviewModel = viewmodel
        self.navigationController?.pushViewController(detailListViewController, animated: true)
    }
}

