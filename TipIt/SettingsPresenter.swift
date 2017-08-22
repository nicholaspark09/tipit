//
//  SettingsPresenter.swift
//  TipIt
//
//  Created by Nicholas Park - Vendor on 8/20/17.
//  Copyright © 2017 Nicholas Park - Vendor. All rights reserved.
//

import Foundation

class SettingsPresenter : SettingsPresenterInterface {
    
    struct Constants {
        static let DEFAULT_RATE: Float = 0.15
        static let TIP_RATES: [Float] = [0.15, 0.2, 0.25]
    }
    
    private var repository: TipDataSource?
    weak private var view: SettingsView?
    
    init(repository: TipDataSource) {
        self.repository = repository
    }
    
    func attachView(view: SettingsView) {
        self.view = view
        getDefaultTipRate()
        getAvailableTipRates()
    }
    
    func detachView() {
        self.view = nil
    }
    
    func getDefaultTipRate() {
        var selectedIndex: Int?
        if (repository?.getTipRate() != nil) {
            selectedIndex = Constants.TIP_RATES.index(of: repository!.getTipRate()!)
            view?.showDefaultTipRate(tipRate: repository!.getTipRate()!.floatToPercentage())
        }else {
            view?.showDefaultTipRate(tipRate: Constants.DEFAULT_RATE.floatToPercentage())
        }
        if selectedIndex == nil {
            selectedIndex = 0
        }
        view?.updateSegmentView(index: selectedIndex!)
    }
    
    func getAvailableTipRates() {
        let rates = Constants.TIP_RATES.map {
            $0.floatToPercentage()
        }
        view?.showAvailableTipRates(rates: rates)
    }
    
    func updatedTipRate(index: Int) {
        view?.showDefaultTipRate(tipRate: Constants.TIP_RATES[index].floatToPercentage())
    }
    
    func save(index: Int) {
        repository?.saveTipRate(rate: Constants.TIP_RATES[index])
        print("Trying to save a tip rate of \(Constants.TIP_RATES[index])")
        view?.showSaved()
    }
}

extension Float {
    func floatToPercentage() -> String {
        return String(format: "%.0f%%", self*100)
    }
    
    func floatToDollarAmount() -> String {
        return String(format: "$%.2f", self)
    }
}
