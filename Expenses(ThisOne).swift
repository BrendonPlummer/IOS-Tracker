//
//  Expenses.swift
//  ExpenseIOS
//
//  Created by Plummer B D D (FCES) on 24/03/2023.
//

import Foundation
import SwiftUI

class Expenses: ObservableObject {
    var currentEditingIndex: Int = 0
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
    
    
    //Toggles whether item has been payed or not
    func toggle(for expense: ExpenseItem){
        if let index = items.firstIndex(where: {$0.id == expense.id}) {
            if(!items[index].expense_Item_Paid) {
                items[index].expense_Item_Paid.toggle()
                setDatePaid(for: expense)
            }
        }
    }
    
    func setDatePaid(for expense: ExpenseItem){
        if let index = items.firstIndex(where: {$0.id == expense.id}) {
            let currentDateTime = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.dateStyle = .long
            items[index].expense_Date_Paid = formatter.string(from: currentDateTime)
        }
    }
    //This is the function to find the current index in the object array, it finds it okay for all other functions but if i try to pass it through to details view it doesnt work 
    func getCurrentIndex(for expense: ExpenseItem)->Int{
        if let index = items.firstIndex(where: {$0.id == expense.id}) {
                return index
        } else {
            return -1
        }
    }
    
    func removeItems(for expense: ExpenseItem) {
        items.remove(at: getCurrentIndex(for: expense))
        
    }
}
