//
//  Expenses.swift
//  iExpense
//
//  Created by Иван Лясковец on 03.08.2023.
//

import Foundation

class Expenses: ObservableObject {
	@Published var items = [ExpenseItem]() {
		didSet {
			if let data = try? JSONEncoder().encode(items) {
				UserDefaults.standard.set(data, forKey: "expenses")
			}
		}
	}
	
	init () {
		guard let data = UserDefaults.standard.object(forKey: "expenses") as? Data else {return}
		if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: data) {
			items = decodedItems
			return
		}
		
		items = []
	}
}
