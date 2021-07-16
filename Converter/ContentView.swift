//
//  ContentView.swift
//  Converter
//
//  Created by Matthew Dias on 7/15/21.
//

import SwiftUI

// CaseIterable gives us all the cases of our enum in an array
// [.fahrenheit, .celsius]
enum TemperatureUnit: String, Identifiable, CaseIterable {
    case fahrenheit
    case celsius

    var id: String {
        return self.rawValue
    }

    func toSymbol() -> String {
        switch self {
            case .fahrenheit:
                return "°F"
            case .celsius:
                return "°C"
        }
    }

    func convert(_ input: Double, to toUnit: TemperatureUnit) -> Double {
        let kelvins = self.toKelvin(input)
        let output = toUnit.fromKelvin(kelvins)

        return output
    }

    func toKelvin(_ number: Double) -> Double {
        switch self {
            case .fahrenheit:
                return (number + 459.67) * 5/9
            case .celsius:
                return number + 273.15
        }
    }

    func fromKelvin(_ number: Double) -> Double {
        switch self {
            case .fahrenheit:
                return (number * 9/5) - 459.67
            case .celsius:
                return number - 273.15
        }
    }
}

struct ContentView: View {
    @State var userInput = ""
    @State var fromUnit: TemperatureUnit = .fahrenheit
    @State var toUnit: TemperatureUnit = .celsius

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("From unit: ")
                Picker("Unit:", selection: $fromUnit) {
                    ForEach(TemperatureUnit.allCases) { unit in
                        Text(unit.rawValue.capitalized).tag(unit)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            HStack {
                Text("To unit: ")
                Picker("Unit:", selection: $toUnit) {
                    ForEach(TemperatureUnit.allCases) { unit in
                        Text(unit.rawValue.capitalized).tag(unit)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            TextField("Temperature in \(fromUnit.toSymbol())", text: $userInput)
            Text("\(convertedInput)")
        }
        .padding()
    }

    var convertedInput: String {
        // could be nil (no value) or a number
        if let inputAsNumber = Double(userInput),
           case let result = fromUnit.convert(inputAsNumber, to: toUnit),
           let formattedNumber = NumberFormatter().string(from: result as NSNumber) {

            return "\(formattedNumber) \(toUnit.toSymbol())"
        } else {
            return "⚠️ enter a #"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
