//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Иван Лясковец on 03.08.2023.
//

import Foundation

struct ExpenseItem: Identifiable {
	let id = UUID()
	let name: String
	let type: String
	let amount: Double
}
