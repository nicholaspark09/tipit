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
        static let TEMP_TIP_KEY = "key_current_rate"
        static let DEFAULT_RATE: Float = 0.15
    }
    
    static let sharedInstance = TipRepository()
    var defaults: UserDefaults?
    
    private init() {
        defaults = UserDefaults.standard
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
