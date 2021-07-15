//
//  ContentView.swift
//  Converter
//
//  Created by Matthew Dias on 7/15/21.
//

import SwiftUI

// goal: Convert Fahrenheit to Celsius
// (32°F − 32) × 5/9 = 0°C
// goal achieved!

struct ContentView: View {
    @State var userInput = ""

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Temperature in °F", text: $userInput)
            Text("\(convertedInput)")
        }
        .padding()
    }

    var convertedInput: String {
        // could be nil (no value) or a number
        if let inputAsNumber = Double(userInput) {
            let result = (inputAsNumber - 32) * 5/9

            return "\(result) °C"
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
