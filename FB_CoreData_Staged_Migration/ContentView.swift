//
//  Created by Axel Le Pennec on 23/02/2024.
//  Copyright © 2024 Axel Le Pennec. All rights reserved.
// 

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .easeInOut
    )
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button("Create Item") {
                        let newItem: Item = Item(context: viewContext)
                        try? viewContext.save()
                    }
                }
                
                Section {
                    ForEach(items) { item in
                        Text(item.identifier?.uuidString ?? "No Identifier")
                    }
                }
            }
        }
    }
}
