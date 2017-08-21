//
//  SettingsViewController.swift
//  TipIt
//
//  Created by Nicholas Park - Vendor on 8/20/17.
//  Copyright © 2017 Nicholas Park - Vendor. All rights reserved.
//

import UIKit

/**
        Acts as the "view" for the presenter for settings
**/

class SettingsViewController: UIViewController, SettingsView {

    struct Constants {
        // TODO Get this from plist later
        static let TITLE = "Settings"
    }
    
    // Outlets
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var currentTipRateLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    //TODO Multiple instances of the repository might be possible, use the app delegate to ensure just one instance is present at any given time
    private let presenter: SettingsPresenter = SettingsPresenter(repository: TipRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.TITLE
        presenter.attachView(view: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.detachView()
    }

    func showDefaultTipRate(tipRate: String) {
        currentTipRateLabel.text = tipRate
    }
    
    func showAvailableTipRates(rates: [String]) {
        for (index, option) in rates.enumerated() {
            segmentControl.setTitle(option, forSegmentAt: index)
        }
    }
    
    func showSaved() {
        showSuccessFlash()
    }
    
    func updateSegmentView(index: Int) {
        segmentControl.selectedSegmentIndex = index
    }
    
    
    // Users events / actions
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        presenter.updatedTipRate(index: sender.selectedSegmentIndex)
    }
    @IBAction func saveClicked(_ sender: Any) {
        presenter.save(index: segmentControl.selectedSegmentIndex)
    }
}
