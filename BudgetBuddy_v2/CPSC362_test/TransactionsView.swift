//
//  TransactionsView.swift
//  CPSC362_test
//
//

import SwiftUI
import Charts

struct TransactionsView: View {
    @ObservedObject private var viewModel:DataManager
    
    init(_ dataManager:DataManager){
        viewModel=dataManager
    }
    
    var body: some View {
        NavigationView(){
            ZStack{
                VStack{
                    List {
                        Section("Graph"){
                            Picker("Graph", selection: $viewModel.graphType) {
                                Text("Category").tag("Category")
                                Text("Month").tag("Month")
                            }
                            .pickerStyle(.segmented)
                            
                            if viewModel.graphType=="Category" {
                                Chart(viewModel.transactions){
                                    BarMark(
                                        x: .value("Type", $0.type),
                                        y: .value("Cost", $0.cost)
                                    )
                                    .foregroundStyle(.linearGradient(colors:[.green,.mint], startPoint: .bottom, endPoint: .top))
                                    .alignsMarkStylesWithPlotArea()
                                }
                                .padding()
                                .aspectRatio(2, contentMode: .fit)
                            }
                            
                            if viewModel.graphType=="Month" {
                                Chart(viewModel.transactions){
                                    BarMark(
                                        x: .value("Date", $0.datetime, unit: .month),
                                        y: .value("Cost", $0.cost)
                                    )
                                    .foregroundStyle(.linearGradient(colors:[.green,.mint], startPoint: .bottom, endPoint: .top))
                                    .alignsMarkStylesWithPlotArea()
                                }
                                .padding()
                                .aspectRatio(2, contentMode: .fit)
                            }
                        }
                        
                        Section("Filter"){
                            Picker("Category", selection: $viewModel.type) {
                                Text("All").tag("All")
                                ForEach(TYPES,id: \.description){
                                    Text($0).tag($0)
                                }
                            }
                        }
                        
                        Section("Transactions"){
                            ForEach(viewModel.transactions){
                                if(viewModel.type=="All") {
                                    TransactionItemView(transaction: $0)
                                } else {
                                    if($0.type==viewModel.type) {
                                        TransactionItemView(transaction: $0)
                                    }
                                }
                            }
                        }
                    }
                    .refreshable {
                        viewModel.getTransactions()
                    }
                }
                .navigationTitle("Transactions")
                .toolbar{
                    NavigationLink( destination: AddTransactionView(viewModel.refresh)){
                        Text("add transaction")
                    }
                }
                .scrollContentBackground(.hidden)
                .background(LinearGradient(gradient: Gradient(colors: [.mint, .white]), startPoint: .top, endPoint: .bottom))
            }
        }
    }
    
    struct TransactionsView_Previews: PreviewProvider {
        static var previews: some View {
            TransactionsView(DataManager())
        }
    }
}
