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
            List (creaturesVM.creaturesArray, id: \.self) { creature in
                NavigationLink {
                    DetailView(creature: creature)
                } label: {
                    Text(creature.name.capitalized)
                        .font(.title2)
                }
                
            }
            .listStyle(.plain)
            .navigationTitle("Pokemon")
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
