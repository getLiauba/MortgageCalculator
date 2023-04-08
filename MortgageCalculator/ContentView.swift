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
    @EnvironmentObject var viewModel: ViewModel

    
    var body: some View {
        
        ZStack {

            LinearGradient(colors: [lightPurple,darkPurple,lightPurple], startPoint: .topTrailing, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.9)
            VStack {
                Display(monthlyPayment: viewModel.mortgage.monthlyPayment)
                Spacer()
                VStack {
                    SliderView(displayValue: 500000.00,label: "Price", maxVal: 3000000, minVal: 50000, step: 10000, isCurrancy: true,endingText: "",infoType: .price)
                        .padding(.bottom,30)
                    
                    SliderView(displayValue: 50000.00,label: "Down Payment", maxVal:  1000000, minVal: 0, step: 5000, isCurrancy: true,endingText: "",infoType: .downPayment)
                        .padding(.bottom,30)
                    SliderView(displayValue: 25.00,label: "Length of Loan", maxVal:  60, minVal: 0, step: 1, isCurrancy: false,endingText: "Years",infoType: .loanLength)
                        .padding(.bottom,30)
                    SliderView(displayValue: 5,label: "Intrest Rate", maxVal:  30, minVal: 0, step: 1, isCurrancy: false,endingText: "%",infoType: .intrestRate)
                }
            }
        }
    }
}


struct Display: View {
    var lightPurple = Color("LightPurple")
    @State var monthlyPayment: Double
    @EnvironmentObject var viewModel: ViewModel
    

       

    
    var body: some View {
        
        var income = Text("\(NumberFormatter.localizedString(from: viewModel.mortgage.yearlyIncome as NSNumber, number: .currency))")
        var monthlyPayments = Text("\(NumberFormatter.localizedString(from: viewModel.mortgage.monthlyPayment as NSNumber, number: .currency))")
        
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 350,height: 250)
                .foregroundColor(Color.gray.opacity(0.2))
                
            
            VStack() {
                
                monthlyPayments
                    .font(.largeTitle.bold())
                + Text(" /Month")
                    .font(.headline.bold())
                
                
                
                income
                    .font(.largeTitle.bold())
                    .padding(.top)
                Text("Yearly income")
                
            }
            .padding(.all,40)
          
        }
        .padding(.top,45)
        


    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
