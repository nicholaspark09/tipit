//
//  TipPresenterUnitTest.swift
//  TipIt
//
//  Created by Nicholas Park - Vendor on 8/19/17.
//  Copyright © 2017 Nicholas Park - Vendor. All rights reserved.
//

import XCTest
@testable import TipIt

class TipPresenterUnitTest: XCTestCase {
    
    struct Constants {
        static let TIP_RATE: Float = 0.15
    }
    
    var mockRepository: TipDataSource!
    var mockView: TipView!
    var presenter: TipPresenter!
    
    override func setUp() {
        super.setUp()
        
        mockRepository = MockRepository()
        mockView = MockView()
        presenter = TipPresenter(tipRepository: mockRepository)
        presenter.attachView(view: mockView)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func attachView_viewShouldBeSet() {
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
 
    class MockRepository : TipDataSource {
        
        func getTipRate() -> Float? {
            return Constants.TIP_RATE
        }
        
        func saveTipRate(rate: Float) {
            print("Tip rate has been saved: \(rate)")
        }
    }
    
    class MockView : NSObject, TipView {
        
        func showTotalsSection(show: Bool) {
            
        }
        
        func showTip(tip: String) {
            
        }
        
        func showTotal(total: String) {
            
        }
        
        func showPerPersonTips(tips: [PerPersonTip]) {
            
        }
        
        func hidePersonTips() {
            
        }
        
        func showTipChange(percent: String) {
            
        }
        
        func showTipChanger(currentTipRate: String) {
            
        }
        
        func showError(message: String) {
            
        }
    }
}
