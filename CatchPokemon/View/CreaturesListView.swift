//
//  ContentView.swift
//  CatchPokemon
//
//  Created by apple on 24.09.2023.
//

import SwiftUI

struct CreaturesListView: View {
    
    @StateObject var  creaturesVM = CreatureViewModel()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                List (0..<creaturesVM.creaturesArray.count, id: \.self) { index in
                    LazyVStack {
                        NavigationLink {
                            DetailView(creature: creaturesVM.creaturesArray[index])
                        } label: {
                            Text("\(index + 1). \(creaturesVM.creaturesArray[index].name.capitalized)")
                                .font(.title2)
                        }
                    }
                    .onAppear{
                        if let lastCreatur = creaturesVM.creaturesArray.last {
                            if creaturesVM.creaturesArray[index].name == lastCreatur.name && creaturesVM.urlString.hasPrefix("http") {
                                Task {
                                    await creaturesVM.getData()
                                }
                            }
                        }
                    }
                    
                }
                .listStyle(.plain)
                .navigationTitle("Pokemon")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Load All") {
                            Task{
                                await creaturesVM.loadAll()
                            }
                           
                        }
                    }
                    ToolbarItem(placement: .status) {
                        Text("\(creaturesVM.creaturesArray.count) of \(creaturesVM.count) creatures")
                    }
                }
                
                if creaturesVM.isLoading {
                    ProgressView()
                        .scaleEffect(4)
                        .tint(.purple)
                }
            }
            
        }
        .task {
            await creaturesVM.getData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreaturesListView()
    }
}
