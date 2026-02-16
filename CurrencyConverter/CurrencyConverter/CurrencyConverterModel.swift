//
//  CurrencyConverterModel.swift
//  CurrencyConverter
//
//  Created by Jeremy Douds on 2/15/26.
//
import Foundation

struct CurrencyRate {
    let code: String
    let rateFromUSD: Double
}

struct CurrencyConverterModel {

    // Example rates (fine for HW). You can change these later.
    private let rates: [CurrencyRate] = [
        .init(code: "Currency 1", rateFromUSD: 0.92),
        .init(code: "Currency 2", rateFromUSD: 0.79),
        .init(code: "Currency 3", rateFromUSD: 148.50),
        .init(code: "Currency 4", rateFromUSD: 1.35)
    ]

    func convert(usd: Int, selectedCodes: [String]) -> [(code: String, value: Double)] {
        let u = Double(usd)
        return rates
            .filter { selectedCodes.contains($0.code) }
            .map { ($0.code, u * $0.rateFromUSD) }
    }
}

