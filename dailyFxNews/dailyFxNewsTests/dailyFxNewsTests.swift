//
//  dailyFxNewsTests.swift
//  dailyFxNewsTests
//
//  Created by raja padala on 06/11/21.
//

import XCTest
@testable import dailyFxNews

class dailyFxNewsTests: XCTestCase {
    
    var service: APIService<Decodable>?
    var viewcontroller: UINavigationController!
    var newsViewModel: NewsViewModel!
    var dataSource : NewsCollectionViewDataSource<HomeScreenCell,DailyFxNews>!
    
    private func setUpViewControllers() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.viewcontroller = storyboard.instantiateViewController(withIdentifier: "NavigationController") as? UINavigationController
        self.viewcontroller.viewDidLoad()
    }
    
    override func setUp() {
        super.setUp()
        self.setUpViewControllers() //Setup viewcontroller
        service = APIService() //initialize APIService class
        newsViewModel = NewsViewModel() //initialize viewmodel class
        newsViewModel.apiService = service //Assign APIService instance to viewmodel
    }
    
    override func tearDown() {
        self.viewcontroller = nil
        service = nil
        newsViewModel = nil
        super.tearDown()
    }
    
    func test_display_data() {
        self.newsViewModel.newsViewModelToController = { error in
            if let err = error {
                DispatchQueue.main.async {
                    self.viewcontroller.viewControllers.first!.showAlert(title: err, message: "", actionTitle: "Ok")
                }
                let expect = XCTestExpectation(description: "Alert message is shown")
            } else {
                let vc: BaseViewController = self.viewcontroller.viewControllers.first! as! BaseViewController
                vc.updateDataSource()
                XCTAssertNotNil(vc, "No data was found.")
            }
        }
    }
    
    func test_fetch_newsApiService() {
        let expect = XCTestExpectation(description: "callback")
        newsViewModel.apiService.fetch(model: DailyFxNews.self, urlString: AppUrls.sourceUrl) { model, error, errorCode in
            self.dataSource = NewsCollectionViewDataSource(cellIdentifier: "HomeScreenCell", items: [self.newsViewModel.newsData], configureCell: { (cell, model, text) in
                
            })
            // Make sure we downloaded some data.
            XCTAssertNotNil(model, "No data was downloaded.")
            
            // Fulfill the expectation to indicate that the background task has finished successfully
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 10.0)
    }
    
    func test_navigatetodetail_screen() {
        let indexPath = IndexPath(item: 0, section: 0)
        if let vc = self.viewcontroller.viewControllers.first {
            let vcontroller: BaseViewController = vc as! BaseViewController
            //dataSource.collectionView(vcontroller.collectionview, didSelectItemAt: indexPath)
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
