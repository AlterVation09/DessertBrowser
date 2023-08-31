//
//  IDessertsApp.swift
//  IDesserts
//
//  Created by Jesus Garcia ibarra on 30/08/23.
//

import SwiftUI

@main                                   //Entry point
struct DessertBrowser: App {
    var body: some Scene {              //Body property returns a scene (root view of the application)
        WindowGroup {                   //Scene consists in windowgroup
            MealListView()              //View to display the list of meals
        }
    }
}
