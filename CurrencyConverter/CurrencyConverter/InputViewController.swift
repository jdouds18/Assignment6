//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Jeremy Douds on 2/15/26.
//

import UIKit

final class InputViewController: UIViewController, UITextFieldDelegate {

    private let model = CurrencyConverterModel()

    @IBOutlet weak var usdTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    @IBOutlet weak var currency1Switch: UISwitch!
    @IBOutlet weak var currency2Switch: UISwitch!
    @IBOutlet weak var currency3Switch: UISwitch!
    @IBOutlet weak var currency4Switch: UISwitch!

    @IBOutlet weak var convertButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.text = ""
        usdTextField.keyboardType = .numberPad
        usdTextField.delegate = self

        // Tap anywhere to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // Integer-only typing (blocks letters/symbols)
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if string.isEmpty { return true } // backspace
        return string.allSatisfy { $0.isNumber }
    }

    @IBAction func convertTapped(_ sender: UIButton) {
        errorLabel.text = ""

        guard let text = usdTextField.text, !text.isEmpty else {
            errorLabel.text = "Enter a USD amount."
            return
        }

        guard let usd = Int(text) else {
            errorLabel.text = "Invalid input. Integer only."
            return
        }

        if usd < 0 {
            errorLabel.text = "USD must be 0 or greater."
            return
        }

        let selected = selectedCurrencyCodes()
        if selected.isEmpty {
            errorLabel.text = "Select at least one currency."
            return
        }

        performSegue(withIdentifier: "ShowResults", sender: usd)
    }

    private func selectedCurrencyCodes() -> [String] {
        var arr: [String] = []
        if currency1Switch.isOn { arr.append("Currency 1") }
        if currency2Switch.isOn { arr.append("Currency 2") }
        if currency3Switch.isOn { arr.append("Currency 3") }
        if currency4Switch.isOn { arr.append("Currency 4") }
        return arr
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowResults",
              let resultsVC = segue.destination as? ResultsViewController,
              let usd = sender as? Int else { return }

        let selected = selectedCurrencyCodes()
        let conversions = model.convert(usd: usd, selectedCodes: selected)

        resultsVC.usdAmount = usd
        resultsVC.conversions = conversions
    }
}
