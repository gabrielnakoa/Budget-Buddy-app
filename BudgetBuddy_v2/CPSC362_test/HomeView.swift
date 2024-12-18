//
//  ContentView.swift
//  CPSC362_test
//
//

import SwiftUI

struct HomeView: View {
    @StateObject var dataManager:DataManager=DataManager()
    var body: some View {
        TabView {
            BudgetView(dataManager)
                .tabItem {
                    Label("Budget", systemImage: "dollarsign.circle.fill")
                }
            TransactionsView(dataManager)
                .tabItem {
                    Label("Transactions", systemImage: "book")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
