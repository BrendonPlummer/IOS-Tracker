//
//  DetailsView.swift
//  ExpenseIOS
//
//  Created by Plummer B D D (FCES) on 24/03/2023.
//

import SwiftUI

struct DetailsView: View {
    @State var item: ExpenseItem
    
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView{
            Form{
                Text("\(item.expense_Name)")
                    .font(.title)
                    .multilineTextAlignment(.center)
                Text(item.expense_Summary)
                HStack{
                    Text(item.expense_VAT_Total, format: .currency(code: "GBP"))
                    Spacer()
                    if(item.expense_VAT_Included){
                        Text("Excl. VAT: £\(String(format: "%.02f", (item.expense_VAT_Total - (item.expense_Amount * 0.2))))")
                            .foregroundColor(Color.gray)
                    } else {
                        Text("Excl. VAT: £\(String(format: "%.02f", item.expense_VAT_Total))")
                            .foregroundColor(Color.gray)
                    }
                }
                Text("Incurred: \(item.expense_Date_Incurred)")
                Text("Recorded: \(item.expense_Date_Added)")
                if(item.expense_Item_Paid){
                    HStack{
                        Image(systemName:"checkmark.circle.fill")
                            .foregroundColor(Color.green)
                        Text("Payment made - \(item.expense_Date_Paid)")
                            .font(.callout)
                            .foregroundColor(Color.green)
                    }
                } else {
                    Text("Expense Unpaid")
                        .font(.callout)
                        .foregroundColor(Color.red)
                }
                Image(systemName: "person.fill")
                    .resizable(resizingMode: .tile)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
            }
            .multilineTextAlignment(.leading)
            .navigationBarTitle("Edit Expense", displayMode: .inline)
            .tint(Color.blue)
        }
    }
}

/*
 @State private var VAT_Included = false
 @State private var name = ""
 @State private var summary = ""
 @State private var amount = 0.0
 @State private var dateIncurred = Date()
 
 
 .toolbar {
     Button("Save") {
         let newItem = ExpenseItem(expense_Name: name,
                                expense_Summary: summary,
                                expense_Amount: amount,
                                expense_VAT_Amount: amount * 0.2,
                                expense_VAT_Included: VAT_Included,
                                expense_Date_Incurred: expenses.convertDateToString(date: dateIncurred),
                                expense_Date_Added: expenses.getCurrentDate(),
                                expense_Date_Paid: "Item Unpaid",
                                expense_Item_Paid: false)
         expenses.items[expenses.getCurrentIndex(for: item)] = newItem
         dismiss()
     }
 
struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        //DetailsView(item: ExpenseItem(from: item))
    }
}
*/
