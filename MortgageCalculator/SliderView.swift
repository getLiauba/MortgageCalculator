//
//  SliderView.swift
//  MortgageCalculator
//
//  Created by andrew liauba on 2023-04-05.
//

import SwiftUI

struct SliderView: View {
    
    @Binding var displayValue: Double
    var label: String
    var maxVal: Int
    var minVal: Int
    var step: Int
    var lightPurple = Color("LightPurple")
    var isCurrancy:Bool
    var endingText: String
    
    var body: some View {
        
        VStack {
            HStack {
                Text("\(label)")
                    .padding(.horizontal,20)
                    .font(.headline.bold())
                    .fontWeight(.heavy)
                Spacer()
                if (isCurrancy) {
                    Text("\(priceAsCurrency())")
                        .padding(.horizontal,20)
                        .font(.headline.bold())
                } else {
                    Text("\(removeTrailingZeros(displayValue)) \(endingText)")
                        .padding(.horizontal,20)
                        .font(.headline.bold())
                }
            }
            Slider(value: $displayValue, in: Double(minVal)...Double(maxVal), step: Double.Stride(step))
                .padding(.horizontal,30)
                .accentColor(.green)
                .opacity(0.5)
        }
    }
    
    func removeTrailingZeros(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16
        formatter.numberStyle = .decimal
        let formatted = formatter.string(from: NSNumber(value: value)) ?? ""
        return formatted.replacingOccurrences(of: "\\.(\\d*?)0+$", with: ".$1", options: .regularExpression)
    }
    
    private func priceAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.maximumFractionDigits = 0
        formatter.roundingMode = .halfUp
        return formatter.string(from: NSNumber(value: displayValue.rounded())) ?? ""
    }
}

//struct SliderView_Previews: PreviewProvider {
//    static var previews: some View {
//        SliderView(displayValue: 1000000, label: "Price", maxVal: 2000000, minVal: 10000, step: 10000,isCurrancy: true)
//    }
//}
