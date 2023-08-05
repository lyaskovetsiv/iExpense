//
//  AddView.swift
//  iExpense
//
//  Created by Иван Лясковец on 03.08.2023.
//

import SwiftUI

struct AddView: View {
	
	@Environment(\.dismiss) var dismiss
	@State private var name: String = ""
	@State private var type: String = "Personal"
	@State private var amount = 0.0
	@ObservedObject var expenses: Expenses
	
	private let types = ["Personal", "Business"]
	private var formatCurrency: FloatingPointFormatStyle<Double>.Currency {
		return .currency(code: Locale.current.currency?.identifier ?? "USD")
	}
	
    var body: some View {
		NavigationView {
			Form {
				TextField("Name", text: $name)
				Picker("Type", selection: $type) {
					ForEach(types, id: \.self) { type in
						Text("\(type)")
						
						
					}
				}
				TextField("Amount", value: $amount, format: formatCurrency)
					.keyboardType(.decimalPad)
			}
			.navigationTitle("Add new expense") 
			.toolbar {
				Button {
					createNewExpense()
					dismiss()
				} label: {
					Text("Save")
				}
			}
		}
    }
	
	private func createNewExpense() {
		let newExpense = ExpenseItem(name: name, type: type, amount: amount)
		expenses.items.append(newExpense)
	}
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
