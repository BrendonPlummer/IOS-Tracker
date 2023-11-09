//
//  ExpenseItem.swift
//  ExpenseIOS
//
//  Created by Plummer B D D (FCES) on 24/03/2023.
//

import Foundation
import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    var expense_Name: String
    var expense_Summary: String
    
    var expense_Amount: Double
    var expense_VAT_Total: Double
    var expense_VAT_Included: Bool
    
    var expense_Date_Incurred: String
    var expense_Date_Added: String
    var expense_Date_Paid: String
    var expense_Item_Paid = false
}
