//
//  SettingsContract.swift
//  TipIt
//
//  Created by Nicholas Park - Vendor on 8/20/17.
//  Copyright © 2017 Nicholas Park - Vendor. All rights reserved.
//

import Foundation

// Protocol that acts as interface for Settings view and presenter
// Defines the methods that the view or presenter must implement so the actual
// implementations don't have to worry about how they work, just that they work

protocol SettingsView: NSObjectProtocol {
    func showDefaultTipRate(tipRate: String)
    func showAvailableTipRates(rates: [String])
    func updateSegmentView(index: Int)
    func showSaved()
}

protocol SettingsPresenterInterface : BasePresenter {
    func attachView(view: SettingsView)
    func getDefaultTipRate()
    func getAvailableTipRates()
    func updatedTipRate(index: Int)
    func save(index: Int)
}
