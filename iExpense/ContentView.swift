//
//  ContentView.swift
//  iExpense
//
//  Created by Иван Лясковец on 03.08.2023.
//

import SwiftUI

struct ContentView: View {
	
	@StateObject var expenses = Expenses()
	@State private var isShowingAddNewExpense = false
	
    var body: some View {
		NavigationView {
			List {
				ForEach(expenses.items, id: \.id) { item in
					Text("\(item.name)")
				}
				.onDelete { indexSet in
					removeItems(at: indexSet)
				}
			}
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
	
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
