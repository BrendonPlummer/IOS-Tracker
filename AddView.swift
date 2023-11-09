//
//  AddView.swift
//  ExpenseIOS
//
//  Created by Plummer B D D (FCES) on 24/03/2023.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var VAT_Included = false
    @State private var name = ""
    @State private var summary = ""
    @State private var amount = 0.0
    @State private var dateIncurred = Date()

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Summary of purchase", text: $summary)
                
                TextField("Amount", value: $amount, format: .currency(code: "GBP"))
                    .keyboardType(.decimalPad)
                
                Toggle("Vat Included:", isOn: $VAT_Included)
                
                DatePicker("Date of purchase:", selection: $dateIncurred, displayedComponents: .date)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    var combinedVATCost = 0.0
                    if (VAT_Included){
                        combinedVATCost = amount
                    } else {
                        combinedVATCost = amount + (amount * 0.2)
                    }
                    let item = ExpenseItem(expense_Name: name,
                                           expense_Summary: summary,
                                           expense_Amount: amount,
                                           expense_VAT_Total: combinedVATCost,
                                           expense_VAT_Included: VAT_Included,
                                           expense_Date_Incurred: expenses.convertDateToString(date: dateIncurred),
                                           expense_Date_Added: expenses.getCurrentDate(),
                                           expense_Date_Paid: "Item Unpaid",
                                           expense_Item_Paid: false)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
