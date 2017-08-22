//
//  TipPresenter.swift
//  TipIt
//
//  Created by Nicholas Park - Vendor on 8/19/17.
//  Copyright © 2017 Nicholas Park - Vendor. All rights reserved.
//

import Foundation

class TipPresenter : TipPresenterInterface {
 
    struct Constants {
        static let MAX_COUNT = 6
    }
    
    var tipPercentage: Float = 0.15
    var repository: TipDataSource?
    var cachedTotal: String?
    weak var view: TipView?
    
    init(tipRepository: TipDataSource) {
        repository = tipRepository
    }
    
    func updateTipPercentage(tipPercentage: Float) {
        self.tipPercentage = tipPercentage
        view?.showTipChange(percent: tipPercentage.floatToPercentage())
        if (cachedTotal != nil) {
            calculateTip(total: cachedTotal)
        }
    }
    
    func calculateTip(total: String?) {
        cachedTotal = total
        if (total == "") {
            view?.showTip(tip: "")
            view?.showTotal(total: "")
            view?.showTotalsSection(show: false)
            view?.hidePersonTips()
            return;
        }
            let preTipTotal = Float(total!);
            if (preTipTotal != nil) {
                let tip = preTipTotal! * tipPercentage
                let totalBill = preTipTotal! + tip
                view?.showTip(tip: tip.floatToDollarAmount())
                view?.showTotal(total: totalBill.floatToDollarAmount())
                view?.showTotalsSection(show: true)
                calculatePerPersonTip(tip: tip, total: preTipTotal!)
                repository?.saveBillAmount(billAmount: preTipTotal!)
            }
    }
    
    func calculatePerPersonTip(tip: Float, total: Float) {
        var arr = [PerPersonTip]()
        // Skip the first person as it's already being shown
        for i in 1..<Constants.MAX_COUNT {
            let individualTip = tip / Float(i+1)
            let formattedTip = individualTip.floatToDollarAmount()
            let preFormattedTotal = individualTip + (total / Float(i+1))
            let total = preFormattedTotal.floatToDollarAmount()
            let perPersonTip = PerPersonTip(numberOfPeople: i+1, tip: formattedTip, total: total)
            arr.append(perPersonTip)
        }
        view?.showPerPersonTips(tips: arr)
    }
    
    func clickedTipPercentage() {
        view?.showTipChanger(currentTipRate: tipPercentage.floatToPercentage())
    }
    
    func attachView(view: TipView) {
        self.view = view
        tipPercentage = repository!.getTipRate()!
        view.showTipChange(percent: tipPercentage.floatToPercentage())
        // Check for a previously saved bill
        if repository?.getSavedBillAmount() != nil {
            cachedTotal = String("\(repository!.getSavedBillAmount())")
            view.showPreviousTotal(total: cachedTotal!)
            calculateTip(total: cachedTotal)
        }
    }
    
    func reattachIfNecessary(view: TipView) {
        if self.view == nil {
            attachView(view: view)
            if (cachedTotal != nil) {
                calculateTip(total: cachedTotal)
            }
        }
    }
    
    func detachView() {
        view = nil
    }
}
