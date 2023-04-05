//
//  ContentView.swift
//  MortgageCalculator
//
//  Created by andrew liauba on 2023-04-05.
//

import SwiftUI

struct ContentView: View {
    
    var lightPurple = Color("LightPurple")
    var darkPurple = Color("DarkPurple")
    var background = Color("Background")
    
//    @State var price = 1000000.00
//    @State var downPayment = 10000.00
//    @State var loanLength = 25.0
//    @State var intrestRate = 5.0
//    @State var monthlyPayment = 0.0
//    @State var yearlyIncome: Double
    
    @State var price:Double
    @State var downPayment:Double
    @State var loanLength:Double
    @State var intrestRate:Double
    @State var monthlyPayment:Double
    @State var yearlyIncome: Double
    
    
    init() {
        
        self.price = 1000000.00
        self.downPayment = 50000.00
        self.loanLength = 25.00
        self.intrestRate = 5.0
        self.monthlyPayment = 5000.00
        self.yearlyIncome = 10000.00
        
        self.monthlyPayment = calculateMortgagePayment(price: price, downPayment: downPayment, loanLength: loanLength, interestRate: intrestRate)
        self.yearlyIncome = calculateIncome(monthlyPayment: monthlyPayment)
        
        
    }
    
    var body: some View {
        
        ZStack {
            // background
            //  .ignoresSafeArea()
            LinearGradient(colors: [lightPurple,darkPurple,lightPurple], startPoint: .topTrailing, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.9)
            VStack {
                VStack {
                    Text(NumberFormatter.localizedString(from: NSNumber(value: calculateMortgagePayment(price: price, downPayment: downPayment, loanLength: loanLength, interestRate: intrestRate)), number: .currency))
                        .font(.largeTitle.bold())
                    + Text("/Month")
                        .font(.headline)
                        .fontWeight(.medium)
                    Text("Your gross income would need to be \(calculateIncome(monthlyPayment: monthlyPayment)) to afford this mortgage")
                        .multilineTextAlignment(.center)
                        .padding(.top,40)
                        .padding(.all)
                        .font(.title2)
                    
                        
                }
                Spacer()
                VStack {
                    SliderView(displayValue: $price, label: "Price", maxVal: 3000000, minVal: 50000, step: 10000, isCurrancy: true,endingText: "")
                        .padding(.bottom,30)
                    
                    SliderView(displayValue: $downPayment, label: "Down Payment", maxVal:  1000000, minVal: 0, step: 10000, isCurrancy: true,endingText: "")
                        .padding(.bottom,30)
                    SliderView(displayValue: $loanLength, label: "Length of Loan", maxVal:  60, minVal: 0, step: 1, isCurrancy: false,endingText: "Years")
                        .padding(.bottom,30)
                    SliderView(displayValue: $intrestRate, label: "Intrest Rate", maxVal:  30, minVal: 0, step: 1, isCurrancy: false,endingText: "%")
                }
            }
        }
    }
}

func calculateMortgagePayment(price: Double, downPayment: Double, loanLength: Double, interestRate: Double) -> Double {
    let loanAmount = price - downPayment
    let monthlyInterestRate = interestRate / 1200.0 // 12 months * 100%
    let numberOfPayments = loanLength * 12.0
    let numerator = loanAmount * monthlyInterestRate * pow((1 + monthlyInterestRate), numberOfPayments)
    let denominator = pow((1 + monthlyInterestRate), numberOfPayments) - 1
    let monthlyPayment = numerator / denominator
    
    return monthlyPayment
}


func calculateIncome(monthlyPayment: Double) -> Double{
    
    let yearlyPayment = monthlyPayment * 12
    
    let onePercent = (yearlyPayment / 32)
    
    return onePercent * 100
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//        LinearGradient(colors: [lightPurple,darkPurple,lightPurple], startPoint: .topTrailing, endPoint: .bottomLeading)
//            .edgesIgnoringSafeArea(.all)
//            .opacity(0.9)
