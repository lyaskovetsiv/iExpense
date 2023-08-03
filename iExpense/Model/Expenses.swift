//
//  Expenses.swift
//  iExpense
//
//  Created by Иван Лясковец on 03.08.2023.
//

import Foundation

class Expenses: ObservableObject {
	@Published var items = [ExpenseItem]()
}
