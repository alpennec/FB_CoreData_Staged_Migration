//
//  Created by Axel Le Pennec on 23/02/2024.
//  Copyright © 2024 Axel Le Pennec. All rights reserved.
// 

import SwiftUI

@main
struct FB_CoreData_Staged_MigrationApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
