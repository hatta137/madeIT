//
//  madeIT_TestApp.swift
//  madeIT-Test
//
//  Created by Hendrik Lendeckel on 18.06.24.
//

import SwiftUI

@main
struct madeIT: App {
    var body: some Scene {
        WindowGroup {
            MadeItTab()
        }
        .modelContainer(for: [Customer.self, Resource.self, Graphic.self])
    }
}
