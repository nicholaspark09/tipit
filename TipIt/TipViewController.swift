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
class TipViewController: UIViewController, TipView, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    struct Constants {
        static let CellReuseIdentifier = "PersonTip Cell"
    }
    
    // Outlets
    @IBOutlet weak var pretotalTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rateButton: UIBarButtonItem!
    
    var perPersonTips = [PerPersonTip?]()
    private let presenter: TipPresenter = TipPresenter(tipRepository: TipRepository.sharedInstance)
    
    /**
        Lifecycle methods
    **/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Start with the totals hidden
        self.totalsView.alpha = 0
        
        // Set the table
        self.tableView.register(UINib(nibName: "TipTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.CellReuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        pretotalTextField.delegate = self
        presenter.attachView(view: self)
        self.hideKeyboardWhenPossible()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("The view will load")
        // For when the user has returned
        presenter.reattachIfNecessary(view: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.detachView()
    }
    // End of lifecycle methods
    
    /**
        TipView protocol methods
    **/
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
    
    func showTipChanger(currentTipRate: String) {
        let title = String(currentTipRate)
        let alertController = UIAlertController(title: title, message: "To change the rate, pick one below:", preferredStyle: UIAlertControllerStyle.actionSheet)
        let fifteenRate = UIAlertAction(title: "15%", style: UIAlertActionStyle.default) { (action) -> Void in
            self.presenter.updateTipPercentage(tipPercentage: 0.15)
        }
        let twentyRate = UIAlertAction(title: "20%", style: UIAlertActionStyle.default) { (action) -> Void in
            self.presenter.updateTipPercentage(tipPercentage: 0.20)
        }
        let twentyFive = UIAlertAction(title: "25%", style: UIAlertActionStyle.default) { (action) -> Void in
            self.presenter.updateTipPercentage(tipPercentage: 0.25)
        }
        alertController.addAction(fifteenRate)
        alertController.addAction(twentyRate)
        alertController.addAction(twentyFive)
        self.present(alertController, animated: true, completion:nil)
    }
    
    func showTipChange(percent: String) {
        rateButton.title = percent
        // To indicate that the rates have been readjusted, animate the view
        if let currentWindow = self.view {
            let view = UIView(frame: currentWindow.bounds)
            UIView.animate(withDuration: 0.4, animations: {
                self.totalsView.frame.origin.x -= view.frame.width
                self.tableView.frame.origin.x -= view.frame.width
            })
        }
    }
    
    func showPerPersonTips(tips: [PerPersonTip]) {
        perPersonTips = tips
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func hidePersonTips() {
        self.tableView.isHidden = true
    }
    // End of TipView protocol methods
    
    /**
        Actions - clicks from the user
    **/
    @IBAction func editTextChanged(_ sender: UITextField) {
        presenter.calculateTip(total: sender.text)
    }
    
    @IBAction func rateClicked(_ sender: Any) {
        presenter.clickedTipPercentage()
    }
    
    /**
        Table View delegate methods
     **/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return perPersonTips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellReuseIdentifier, for: indexPath) as! TipTableViewCell
        let perPersonTip = perPersonTips[indexPath.row]
        cell.personTip = perPersonTip!
        return cell
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
    
    func showSuccessFlash() {
        if let currentWindow = self.view {
            let view = UIView(frame: currentWindow.bounds)
            view.backgroundColor = UIColor.green
            view.alpha = 1
            currentWindow.addSubview(view)
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                view.alpha = 0
            }, completion: { (finished: Bool) in
                view.removeFromSuperview()
                
            })
        }
    }
}

