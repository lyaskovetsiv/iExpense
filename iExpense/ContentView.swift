//
//  ContentView.swift
//  iExpense
//
//  Created by Иван Лясковец on 03.08.2023.
//

import SwiftUI

struct ContentView: View {
	
	// MARK: - States
	
	@StateObject var expenses = Expenses()
	@State private var isShowingAddNewExpense = false
	@State private var sections = ["Personal", "Business"]
	
	// MARK: - Private properties
	
	private var formatCurrency: FloatingPointFormatStyle<Double>.Currency {
		return .currency(code: Locale.current.currency?.identifier ?? "USD")
	}
	
	// MARK: - UI
	
	var body: some View {
		NavigationView {
			List {
				ForEach(sections, id: \.self) { section in
					Section(header: Text(section)) {
						ForEach(expenses.items.filter({ $0.type == section}),
								id: \.id) { item in
							HStack {
								VStack (alignment: .leading) {
									Text(item.name)
										.font(.headline)
									Text(item.type)
								}
								Spacer()
								Text(item.amount, format: formatCurrency)
									.foregroundColor(checkColor(amount: item.amount))
							}
						}
						.onDelete { indexSet in
							removeItemFromSection(at: indexSet, section: section)
						}
					}
				}
				
			}
			.listStyle(.grouped)
			.navigationTitle("iExpense")
			.toolbar {
				Button {
					isShowingAddNewExpense.toggle()
				} label: {
					Image(systemName: "plus")
				}
			}
		}
		.sheet(isPresented: $isShowingAddNewExpense) {
			AddView(expenses: expenses)
		}
	}
	
	// MARK: - Private methods
	
	private func removeItemFromSection(at offsets: IndexSet, section: String) {
		let sectionExpenses  = expenses.items.filter { $0.type == section }
		let expensesToDelete = offsets.map { sectionExpenses[$0] }
		for expense in expensesToDelete {
			if let index = expenses.items.firstIndex(where: { exp in
				exp.id == expense.id
			}) {
				expenses.items.remove(at: index)
			}
		}
	}
	
	private func checkColor(amount: Double) -> Color {
		if amount < 10 {
			return Color.green
		} else if amount < 100 {
			return Color.orange
		} else {
			return Color.red
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
