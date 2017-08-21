//
//  TipContract.swift
//  TipIt
//
//  Created by Nicholas Park - Vendor on 8/19/17.
//  Copyright © 2017 Nicholas Park - Vendor. All rights reserved.
//

import Foundation

// Protocol that views must implement to act as the tip view 
// Should be the controllers themselves
// This allows for the view to be switched out if there needs to be a dramatic ui update
protocol TipView: NSObjectProtocol {
    func showTotalsSection(show: Bool)
    func showTip(tip: String)
    func showTotal(total: String)
    func showPerPersonTips(tips: [PerPersonTip])
    func hidePersonTips()
    func showTipChange(percent: String)
    func showTipChanger(currentTipRate: String)
    func showError(message: String)
}

// Protocol that defines how implementations should handle the business logic
protocol TipPresenterInterface : BasePresenter {
    func clickedTipPercentage()
    func updateTipPercentage(tipPercentage: Float)
    func calculateTip(total: String?)
    func calculatePerPersonTip(tip: Float, total: Float)
    func attachView(view: TipView)
    func reattachIfNecessary(view: TipView)
}
