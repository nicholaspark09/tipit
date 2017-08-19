//
//  ViewController.swift
//  TipIt
//
//  Created by Nicholas Park - Vendor on 8/19/17.
//  Copyright © 2017 Nicholas Park - Vendor. All rights reserved.
//

import UIKit

class TipViewController: UIViewController, TipView, UITextFieldDelegate {

    // Outlets
    @IBOutlet weak var pretotalTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    
    private let presenter: TipPresenter = TipPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pretotalTextField.delegate = self
        presenter.attachView(view: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.detachView()
    }
    
    func showTip(tip: String) {
        tipLabel.text = tip
    }
    
    func showTotal(total: String) {
        totalLabel.text = total
    }
    
    func showError(message: String) {
        
    }
    
    @IBAction func editTextChanged(_ sender: UITextField) {
        print("The pretotal changed to \(String(describing: sender.text))")
        presenter.calculateTip(total: sender.text)
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            presenter.updateTipPercentage(tipPercentage: 0.15)
            break;
        case 1:
            presenter.updateTipPercentage(tipPercentage: 0.20)
            break;
        default:
            break;
        }
    }
}

