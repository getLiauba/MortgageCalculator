//
//  ViewModel.swift
//  MortgageCalculator
//
//  Created by andrew liauba on 2023-04-08.
//

import Foundation


class ViewModel:ObservableObject {
    
    @Published var mortgage: PaymentsModel = PaymentsModel()
    
    
    init() {
        
        calculateMortgagePayment(price: mortgage.price, downPayment: mortgage.downPayment, loanLength: mortgage.loanLength, interestRate: mortgage.intrestRate)
        calculateIncome(monthlyPayment: mortgage.monthlyPayment)
    }
    
    func setPrice(price:Double) {
        mortgage.price = price
        calculateMortgagePayment()
        calculateIncome()
    }
    
    func setDownPayment(downPayment:Double) {
        mortgage.downPayment = downPayment
        calculateMortgagePayment()
        calculateIncome()
    }
    
    func setLoanLength(loanLength:Double) {
        mortgage.loanLength = loanLength
        calculateMortgagePayment()
        calculateIncome()
    }
    
    func setInrestRate(intrestRate:Double) {
        mortgage.intrestRate = intrestRate
        calculateMortgagePayment()
        calculateIncome()
    }
    
    func setMonthlyPayment(monthlyPayment:Double) {
        mortgage.monthlyPayment = monthlyPayment
        calculateMortgagePayment()
        calculateIncome()
    }
    func setYearlyIncome(yearlyIncome:Double) {
        mortgage.yearlyIncome = yearlyIncome
        calculateMortgagePayment()
        calculateIncome()
    }
    
    
    
    func calculateMortgagePayment(price: Double, downPayment: Double, loanLength: Double, interestRate: Double){
        let loanAmount = price - downPayment
        let monthlyInterestRate = interestRate / 1200.0 // 12 months * 100%
        let numberOfPayments = loanLength * 12.0
        let numerator = loanAmount * monthlyInterestRate * pow((1 + monthlyInterestRate), numberOfPayments)
        let denominator = pow((1 + monthlyInterestRate), numberOfPayments) - 1
        let monthlyPayment = numerator / denominator
        
        mortgage.monthlyPayment = monthlyPayment
    }
    
    func calculateMortgagePayment(){
        
        let price = mortgage.price
        let downPayment = mortgage.downPayment
        let interestRate = mortgage.intrestRate
        let loanLength = mortgage.loanLength
        
        let loanAmount = price - downPayment
        let monthlyInterestRate = interestRate / 1200.0 // 12 months * 100%
        let numberOfPayments = loanLength * 12.0
        let numerator = loanAmount * monthlyInterestRate * pow((1 + monthlyInterestRate), numberOfPayments)
        let denominator = pow((1 + monthlyInterestRate), numberOfPayments) - 1
        let monthlyPayment = numerator / denominator
        
        mortgage.monthlyPayment = monthlyPayment
    }

    func calculateIncome(monthlyPayment:Double) {
        let yearlyPayment = monthlyPayment * 12
        
        let onePercent = (yearlyPayment / 32)
        
        mortgage.yearlyIncome = onePercent * 100
    }
    
    func calculateIncome() {
        let monthlyPayment = mortgage.monthlyPayment
        let yearlyPayment = monthlyPayment * 12
        
        let onePercent = (yearlyPayment / 32)
        
        mortgage.yearlyIncome = onePercent * 100
    }
    
}
