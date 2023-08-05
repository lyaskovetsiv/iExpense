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
	
	// MARK: - Private properties
	
	private var formatCurrency: FloatingPointFormatStyle<Double>.Currency {
		return .currency(code: Locale.current.currency?.identifier ?? "USD")
	}
	
	// MARK: - UI
	
    var body: some View {
		NavigationView {
			List {
				Section {
					ForEach(expenses.items.filter({ $0.type == "Personal"}),
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
						removeItems(at: indexSet)
					}
				} header: {
					Text ("Personal")
				}
				
				Section {
					ForEach(expenses.items.filter({ $0.type == "Business"}),
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
						removeItems(at: indexSet)
					}
				} header: {
					Text ("Business")
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
	
	private func removeItems(at offsets: IndexSet) {
		expenses.items.remove(atOffsets: offsets)
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
