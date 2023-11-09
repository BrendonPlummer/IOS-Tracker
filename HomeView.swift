//
//  ContentView.swift
//  ExpenseIOS
//
//  Created by Plummer B D D (FCES) on 24/03/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var expenses = Expenses()

    @State private var showingAddExpense = false
    @State private var editIsActive = false
    @State var searchText = ""
    @State private var selectedExpense: ExpenseItem = ExpenseItem(expense_Name: "",
                                                                      expense_Summary: "",
                                                                  expense_Amount: 0,
                                                                      expense_VAT_Total: 0,
                                                                      expense_VAT_Included: false,
                                                                      expense_Date_Incurred: "",
                                                                      expense_Date_Added: "",
                                                                      expense_Date_Paid: "",
                                                                      expense_Item_Paid: false)
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items.filter({"\($0.expense_Name)".contains(searchText) || searchText.isEmpty})) { item in
                    VStack{
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.expense_Name)
                                    .font(.headline)
                                Text(item.expense_Summary)
                                    .fontWeight(.light)
                                    .lineLimit(2)
                            }
                            Spacer()
                            VStack{
                                Text(item.expense_VAT_Total, format: .currency(code: "GBP"))
                                if(item.expense_VAT_Included){
                                    Text("Excl. VAT: £\(String(format: "%.02f", (item.expense_VAT_Total - (item.expense_Amount * 0.2))))")
                                        .foregroundColor(Color.gray)
                                        .fontWeight(.light)
                                } else {
                                    Text("Excl. VAT: £\(String(format: "%.02f", item.expense_Amount))")
                                        .foregroundColor(Color.gray)
                                        .fontWeight(.light)
                                }
                            }
                        }
                        if(item.expense_Item_Paid){
                            HStack{
                                Text("Expense Paid")
                                    .foregroundColor(Color.green)
                                    .multilineTextAlignment(.center)
                                Image(systemName:"checkmark.circle.fill")
                                    .foregroundColor(Color.green)
                            }
                        }
                    }
                    .frame(height: 75)
                    .swipeActions(edge: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/, allowsFullSwipe: false) {
                        Button(role: .destructive){
                            expenses.removeItems(for: item)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        Button{
                            selectedExpense = item
                            editIsActive.toggle()
                            
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/) {
                        Button{
                            expenses.toggle(for: item)
                        } label: {
                            if item.expense_Item_Paid {
                                Image(systemName:"checkmark.circle.fill")
                                    .resizable()
                                    .foregroundColor(Color.green)
                            } else {
                                Image(systemName:"checkmark.circle")
                                    .resizable()
                            }
                        }
                    }
                    NavigationLink(destination: DetailsView(item: selectedExpense, expenses: expenses), isActive: $editIsActive){
                    }.hidden()
                }
            }
            .navigationBarTitle("Expenses", displayMode: .inline)
            .toolbar(){
                ToolbarItem(placement: .navigationBarLeading){
                    Menu{
                        Picker(selection: $expenses.sortBy, label: Text("Sorting Options")){
                            Text("Name Ascending").tag(0)
                            Text("Name Descending").tag(1)
                            Text("Cost Ascending").tag(2)
                            Text("Cost Descending").tag(3)
                            Text("Show Paid").tag(4)
                            Text("Show Unpaid").tag(5)
                        }
                    }label:{
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        showingAddExpense = true
                    } label: {
                        Image(systemName: "plus")
                    } .sheet(isPresented: $showingAddExpense) {
                        AddView(expenses: expenses)
                    }
                }
            }
        }.searchable(text: $searchText)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
