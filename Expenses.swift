//
//  Expenses.swift
//  ExpenseIOS
//
//  Created by Plummer B D D (FCES) on 24/03/2023.
//

import Foundation
import SwiftUI

class Expenses: ObservableObject {
    
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    @Published var sortBy:Int = 0{
        didSet{
            switch sortBy{
            case 0:
                items.sort{
                    $0.expense_Name < $1.expense_Name
                }
            case 1:
                items.sort{
                    $0.expense_Name > $1.expense_Name
                }
            case 2:
                items.sort{
                    $0.expense_VAT_Total < $1.expense_VAT_Total
                }
            case 3:
                items.sort{
                    $0.expense_VAT_Total > $1.expense_VAT_Total
                }
            case 4:
                items.sort{
                    $0.expense_Date_Paid < $1.expense_Date_Paid
                }
            case 5:
                items.sort{
                    $0.expense_Date_Paid > $1.expense_Date_Paid
                }
            default:
                sortBy = 0
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
    
    func getCurrentIndex(for expense: ExpenseItem)->Int{
        if let index = items.firstIndex(where: {$0.id == expense.id}) {
                return index
        } else {
            return -1
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
    
    func removeItems(for expense: ExpenseItem) {
        items.remove(at: getCurrentIndex(for: expense))
    }
    func getCurrentDate() -> String {
        let currentDateTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: currentDateTime)
    }
    
    func convertDateToString(date: Date) ->String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    }
}
