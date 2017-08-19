//
//  TipPresenter.swift
//  TipIt
//
//  Created by Nicholas Park - Vendor on 8/19/17.
//  Copyright © 2017 Nicholas Park - Vendor. All rights reserved.
//

import Foundation

class TipPresenter : TipPresenterInterface {
 
    weak private var view: TipView?
    var tipPercentage: Float = 0.15
    
    func updateTipPercentage(tipPercentage: Float) {
        self.tipPercentage = tipPercentage
    }
    
    func calculateTip(total: String?) {
        if (total == nil) { return; }
            let preTipTotal = Float(total!);
            if (preTipTotal != nil) {
                let tip = preTipTotal! * tipPercentage
                let totalBill = preTipTotal! + tip
                view?.showTip(tip: String(format:"$%.2f", tip))
                view?.showTotal(total: String(format:"$%.2f", totalBill))
                print("the tip is \(tip) and the total is \(totalBill)")
            }
    }
    
    func attachView(view: TipView) {
        self.view = view
    }
    
    func detachView() {
        view = nil
    }
}
