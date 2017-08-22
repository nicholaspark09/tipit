//
//  TipDataSource.swift
//  TipIt
//
//  Created by Nicholas Park - Vendor on 8/19/17.
//  Copyright © 2017 Nicholas Park - Vendor. All rights reserved.
//

import Foundation

protocol TipDataSource {
    func getSavedBillAmount() -> Float
    func saveBillAmount(billAmount: Float)
    func getTipRate() -> Float?
    func saveTipRate(rate: Float)
}
