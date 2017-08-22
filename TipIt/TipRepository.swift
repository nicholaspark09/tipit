//
//  TipRepository.swift
//  TipIt
//
//  Created by Nicholas Park - Vendor on 8/19/17.
//  Copyright © 2017 Nicholas Park - Vendor. All rights reserved.
//

import UIKit

class TipRepository : TipDataSource {
    
    struct Constants {
        static let TIP_KEY = "key_rate"
        static let BILL_KEY = "key_bill"
        static let BILL_TIME = "key_bill_date"
        static let DEFAULT_RATE: Float = 0.15
        static let TIME_EXPIRATION: Int = 10 * 60 // 10 minutes
    }
    
    static let sharedInstance = TipRepository()
    var defaults: UserDefaults?
    
    private init() {
        defaults = UserDefaults.standard
    }
    
    func getSavedBillAmount() -> Float {
        if (defaults?.float(forKey: Constants.BILL_KEY) != nil) {
            let now = Int(NSDate().timeIntervalSince1970)
            let previousTime = defaults!.integer(forKey: Constants.BILL_TIME)
            if (now - previousTime) < Constants.TIME_EXPIRATION {
                return defaults!.float(forKey: Constants.BILL_KEY)
            }
        }
        return 0
    }
    
    func saveBillAmount(billAmount: Float) {
        let now = Int(NSDate().timeIntervalSince1970)
        defaults?.set(billAmount, forKey: Constants.BILL_KEY)
        defaults?.set(now, forKey: Constants.BILL_TIME)
        defaults?.synchronize()
    }
    
    func getTipRate() -> Float? {
        let rate = defaults?.float(forKey: Constants.TIP_KEY)
        if (rate == nil || rate == 0.0) {
            saveTipRate(rate: Constants.DEFAULT_RATE)
            return Constants.DEFAULT_RATE
        }
        return rate
    }
    
    func saveTipRate(rate: Float) {
        defaults?.set(rate, forKey: Constants.TIP_KEY)
        defaults?.synchronize()
    }
}
