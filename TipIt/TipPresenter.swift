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
        static let maxCount = 6
    }
    
    weak private var view: TipView?
    var tipPercentage: Float = 0.15
    private var repository: TipRepository?
    private var cachedTotal: String?
    
    init(tipRepository: TipRepository) {
        repository = tipRepository
    }
    
    func updateTipPercentage(tipPercentage: Float) {
        self.tipPercentage = tipPercentage
        repository?.saveTipRate(rate: tipPercentage)
        view?.showTipChange(percent: String("\(tipPercentage*100)%"))
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
                view?.showTip(tip: String(format:"$%.2f", tip))
                view?.showTotal(total: String(format:"$%.2f", totalBill))
                view?.showTotalsSection(show: true)
                calculatePerPersonTip(tip: tip, total: preTipTotal!)
            }
    }
    
    func calculatePerPersonTip(tip: Float, total: Float) {
        var arr = [PerPersonTip]()
        // Skip the first person as it's already being shown
        for i in 1..<Constants.maxCount {
            let individualTip = tip / Float(i+1)
            let formattedTip = String(format: "$%.2f", individualTip)
            let preFormattedTotal = individualTip + (total / Float(i+1))
            let total = String(format: "$%.2f", preFormattedTotal)
            let perPersonTip = PerPersonTip(numberOfPeople: i+1, tip: formattedTip, total: total)
            arr.append(perPersonTip)
        }
        view?.showPerPersonTips(tips: arr)
    }
    
    func clickedTipPercentage() {
        view?.showTipChanger(currentTipRate: String(format:"\(tipPercentage*100)%"))
    }
    
    func attachView(view: TipView) {
        self.view = view
        tipPercentage = repository!.getTipRate()!
        print("The percentage rate is \(repository!.getTipRate()!)")
        view.showTipChange(percent: String("\(tipPercentage*100)%"))
    }
    
    func detachView() {
        view = nil
    }
}
