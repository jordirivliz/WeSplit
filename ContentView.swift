//
//  ContentView.swift
//  WeSplit
//
//  Created by Jordi Rivera Lizarralde on 29/6/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        // Calculate the total per person here
        let people = Int(numberOfPeople) ?? 0
        let peopleCount = Double(people + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        
        // Try to convert checkAmount to double. If it fails returns 0
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        // Calculate the total per person here
        let tipSelection = Double(tipPercentages[tipPercentage])
        
        // Try to convert checkAmount to double. If it fails returns 0
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationView {
            Form {
                // Section for amount
                Section {
                    // Read input from user to get total amount
                    TextField("Amount", text: $checkAmount)
                        // Change keyboard to only numbers and decimal
                        .keyboardType(.decimalPad)
                    
                    // Read input from user to get number of people
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                // Section for tip percentages
                // Use header to pose a question to user elegantly
                Section(header: Text("How much tip do you want to leave?")) {
                    // Picker for percentages
                    Picker("Tip percentage", selection: $tipPercentage) {
                        // Loop over possible percentages
                        ForEach(0 ..< tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                // Section for totalPerPerson
                Section(header: Text("Amount per person")) {
                    // Only need 2 decimals so we use specifier
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                // Section for total amount for the check
                Section(header: Text("Total amount with tip included")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                }
            }
            // Add title to the navigation view
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
