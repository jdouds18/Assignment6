//
//  ResultsViewController.swift
//  CurrencyConverter
//
//  Created by Jeremy Douds on 2/15/26.
//
import UIKit

final class ResultsViewController: UIViewController {

    var usdAmount: Int = 0
    var conversions: [(String, Double)] = []

    @IBOutlet weak var usdLabel: UILabel!

    @IBOutlet weak var row1Stack: UIStackView!
    @IBOutlet weak var row1Name: UILabel!
    @IBOutlet weak var row1Value: UILabel!

    @IBOutlet weak var row2Stack: UIStackView!
    @IBOutlet weak var row2Name: UILabel!
    @IBOutlet weak var row2Value: UILabel!

    @IBOutlet weak var row3Stack: UIStackView!
    @IBOutlet weak var row3Name: UILabel!
    @IBOutlet weak var row3Value: UILabel!

    @IBOutlet weak var row4Stack: UIStackView!
    @IBOutlet weak var row4Name: UILabel!
    @IBOutlet weak var row4Value: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }

    private func render() {
        usdLabel.text = "Amount in USD: \(usdAmount)"

        let rows = [
            (row1Stack, row1Name, row1Value),
            (row2Stack, row2Name, row2Value),
            (row3Stack, row3Name, row3Value),
            (row4Stack, row4Name, row4Value)
        ]

        for i in 0..<rows.count {
            let stack = rows[i].0!
            let nameLabel = rows[i].1!
            let valueLabel = rows[i].2!

            if i < conversions.count {
                stack.isHidden = false
                nameLabel.text = conversions[i].0
                valueLabel.text = String(format: "%.2f", conversions[i].1)
            } else {
                stack.isHidden = true
            }
        }

    }
}


