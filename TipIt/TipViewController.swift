//
//  ViewController.swift
//  TipIt
//
//  Created by Nicholas Park - Vendor on 8/19/17.
//  Copyright © 2017 Nicholas Park - Vendor. All rights reserved.
//

import UIKit

// Implementatin of TipView
// Handles the view and ui - should be as simple as possible
class TipViewController: UIViewController, TipView, UITextFieldDelegate {

    var tips: [Float] = [0.15, 0.20, 0.25]
    
    // Outlets
    @IBOutlet weak var pretotalTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalsView: UIView!
    
    private let presenter: TipPresenter = TipPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Start with the totals hidden
        self.totalsView.alpha = 0
        pretotalTextField.delegate = self
        presenter.attachView(view: self)
        self.hideKeyboardWhenPossible()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.detachView()
    }
    
    func showTotalsSection(show: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.totalsView.alpha = (show ? 1 : 0)
            }, completion: nil)
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
        presenter.calculateTip(total: sender.text)
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex < tips.count) {
            presenter.updateTipPercentage(tipPercentage: tips[sender.selectedSegmentIndex])
        }
    }
}

extension UIViewController {
    
    func hideKeyboardWhenPossible() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

